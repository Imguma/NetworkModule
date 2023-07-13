//
//  NetworkURL.swift
//  NetworkModule
//
//  Created by 애니모비 on 2023/07/13.
//

import Foundation

// TODO: - 전역으로 둘지 객체 안에 둘지 고민중..
public var isService: Bool = false

public struct NetworkURL {
    // 서비스 & 개발 지정 (지연 연산됨)
//    public static var isService: Bool = false
    
    // 타입 프로퍼티로 선언 > 타입 자체에 속하므로 인스턴스 생성 여부와 관계없이 타입프로퍼티의 값은 딱 하나 뿐
    public static var isDebugMode: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    public static func getBaseURL() -> String {
        if isService || !NetworkURL.isDebugMode {
            // 서비스 주소
            return "service"
        } else {
            // 개발 주소
            return "develope"
        }
    }
    
    public static func getDomain() -> String {
        if isService || !NetworkURL.isDebugMode {
            // 서비스 주소
            return "service"
        } else {
            // 개발 주소
            return "develope"
        }
    }
    
    static let DEF_DEVICE_MSG_URL = "/m/2.0/grp_account/device_message.php"  // device
    static let DEF_PUSH_URL = "/m/push/register_push_device_id.php"          // push
    static let DEF_INTRO_URL = "/m/2.0/grp_account/intro_message.php"        // intro
}
