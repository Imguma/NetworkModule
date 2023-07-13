//
//  CustomError.swift
//  NetworkModule
//
//  Created by 애니모비 on 2023/07/13.
//

import Foundation

// Rest api error
public enum APIError: Error {
    case invalidResponse(Int)
    case noneData
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidResponse(let statusCode):
            switch statusCode {
            case (300...399):
                return "redirection"
            case (400...499):
                return "client error"
            case (500...599):
                return "server error"
            default:
                return "default error"
            }
        case .noneData:
            return "값을 불러오지 못했습니다."
        }
    }
}
