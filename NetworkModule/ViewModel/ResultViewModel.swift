//
//  ResultViewModel.swift
//  NetworkModule
//

import Foundation

open class ViewModel: ObservableObject {
    // 네트워크 객체
    private var network: AFNetwork

    // 생성 및 초기화
    public init(network: AFNetwork = AFNetwork()) {
        self.network = network
    }

    /*
     MARK: 결과 데이터를 특정 데이터 모델로 디코딩 하여 사용하고 싶을 때
     📍 Parameters
       @ resource: 요청 리소스(url, params, encoding, headers, method)
     
     📍 Returns
       @ responseData: 응답 데이터
       @ statusCode: 상태 코드
     */
    public func fetchDecodeData<T: Decodable>(_ resource: Resource<T>) async throws -> (responseData: T, statusCode: Int)? {
        let response = try await network.urlRequest(resource)
        
        switch response.result {
        case .success:
            let responseData = try JSONDecoder().decode(T.self, from: response.result.get())
            
            return (responseData, response.statusCode)
        case .failure(let e):
            print(e.localizedDescription)
            throw APIError.invalidResponse(response.statusCode)
        }
    }

    /*
     MARK: 결과 데이터를 딕셔너리로 사용하고 싶을 때
     📍 Parameters
       @ resource: 요청 리소스(url, params, encoding, headers, method)
      
     📍 Returns
       @ responseData: 응답 데이터
       @ statusCode: 상태 코드
     */
    public func getDataWithDictionary<T>(_ resource: Resource<T>) async throws -> (responseData: [String: Any]?, statusCode: Int)? {
        let response = try await network.urlRequest(resource)
        
        switch response.result {
        case .success:
            let data = try response.result.get()
            let jsonDictionary = ResponseManager.convertDataToDictionary(data: data)
            
            return (jsonDictionary, response.statusCode)
        case .failure(let e):
            print(e.localizedDescription)
            throw APIError.invalidResponse(response.statusCode)
        }
    }
    
    /*
     MARK: 파일 다운로드 결과
     📍 Parameters
       @ resource: 요청 리소스(url, params, encoding, headers, method)
      
     📍 Returns
       @ statusCode: 상태 코드
     */
    public func fetchDownload<T: Decodable>(_ resource: Resource<T>) async throws -> Int? {
        let response = try await network.urlDownload(resource)
        
        switch response.result {
        case .success:
            return response.statusCode
        case .failure(let e):
            print(e.localizedDescription)
            throw APIError.invalidResponse(response.statusCode)
        }
    }
}
