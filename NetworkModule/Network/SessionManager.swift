//
//  SessionManager.swift
//  NetworkModule
//

import Foundation
import Alamofire

public class SessionManager {
    /*
      MARK: Alamofire request 생성 및 관리 Session 생성, 커스텀 타임아웃 지정
      📍 Parameters
        @ timeoutForRequest: 추가 데이터가 올 떄까지 대기하는 시간 (system default: 60s)
        @ timeoutForResource: 리소스가 전송될 때까지 대기하는 시간 (system default: 7days)
     
      📍 Returns
        @ Session
      */
    public static func createSession(timeoutForRequest: Double = 60, timeoutForResource: Double = 300) -> Session {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = timeoutForRequest
        configuration.timeoutIntervalForResource = timeoutForResource
        let session = Session(configuration: configuration)
        
        return session
    }
}
