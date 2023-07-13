//
//  AFNetwork.swift
//  NetworkModule
//

import Foundation
import Combine
import Alamofire
import AlamofireNetworkActivityLogger

protocol NetworkInterface {
    func urlRequest<T>(_ resource: Resource<T>) async throws -> (result: Result<Data, AFError>, statusCode: Int)
    func urlUpload<T>(_ resource: Resource<T>) async throws -> (result: Result<Data, AFError>, statusCode: Int)
    func urlDownload<T>(_ resource: Resource<T>) async throws -> (result: Result<URL, AFError>, statusCode: Int)
}

public class AFNetwork: NetworkInterface, ObservableObject {
    // 디버깅 모드에서만 네트워크 로깅
    public init() {
        if NetworkURL.isDebugMode {
            NetworkActivityLogger.shared.level = .debug
            NetworkActivityLogger.shared.startLogging()
        } else {
            NetworkActivityLogger.shared.level = .off
            NetworkActivityLogger.shared.stopLogging()
        }
    }
    
    // request 함수
    func urlRequest<T>(_ resource: Resource<T>) async throws -> (result: Result<Data, AFError>, statusCode: Int) {
        let url = resource.base + resource.path
        let session = SessionManager.createSession()
        let request = session.request(url, method: resource.method, parameters: resource.params, encoding: resource.encoding, headers: resource.headers)
        let result = await request.serializingData().result
        guard let statusCode = request.response?.statusCode else { throw APIError.noneData }
        
        return (result, statusCode)
    }
    
    // upload 함수
    func urlUpload<T>(_ resource: Resource<T>) async throws -> (result: Result<Data, AFError>, statusCode: Int) {
        let url = resource.base + resource.path
        let session = SessionManager.createSession()
        let request = session.upload(multipartFormData: { MultipartFormData in
            for (key, value) in resource.params {
                MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: url, usingThreshold: UInt64.init(), method: resource.method, headers: resource.headers)

        let result = await request.serializingData().result
        guard let statusCode = request.response?.statusCode else { throw APIError.noneData }
        
        return (result, statusCode)
    }
    
    // file download 함수
    func urlDownload<T>(_ resource: Resource<T>) async throws -> (result: Result<URL, AFError>, statusCode: Int) {
        let fileManager = FileManager.default
        // 앱 경로
        let appURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // 파일이름 url 의 맨 뒤 컴포넌트로 지정 (??.zip)
        let fileName : String = URL(string: resource.base)!.lastPathComponent
        // 파일 경로 생성
        let fileURL = appURL.appendingPathComponent(fileName)
        // 파일 경로 지정 및 다운로드 옵션 설정 ( 이전 파일 삭제 , 디렉토리 생성 )
        let destination: DownloadRequest.Destination = { _, _ in
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        let session = SessionManager.createSession()
        let request = session.download(resource.base, method: resource.method, encoding: resource.encoding, to: destination)
        
        let relay = PassthroughSubject<Double, Never>()
        let observer = ProgressObserver.shared
        let subscription = relay.sink { value in
            observer.progress = value
        }
        
        let result = await request
            .downloadProgress { progress in
                relay.send(progress.fractionCompleted)
            }
            .serializingDownloadedFileURL()
            .result
        
        guard let statusCode = request.response?.statusCode else { throw APIError.noneData }
        subscription.cancel()
        
        return (result, statusCode)
    }
}
