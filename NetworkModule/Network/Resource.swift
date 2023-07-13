//
//  Resource.swift
//  NetworkModule
//

import Foundation
import Alamofire

// 네트워크 요청 리소스
public struct Resource<T: Decodable> {
    var base: String
    var path: String
    var params: [String: String]
    var encoding: ParameterEncoding
    var headers: HTTPHeaders
    var method: HTTPMethod
    
    public init(base: String, path: String, params: [String: String] = [:], encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders, method: HTTPMethod) {
        self.base = base
        self.path = path
        self.params = params
        self.encoding = encoding
        self.headers = headers
        self.method = method
    }
}
