//
//  NetworkError.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 26/09/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    
    case notAuthenticated
    case notFound
    case networkProblem
    case badRequest
    case requestFailed
    case invalidData
    case unknown(HTTPURLResponse?)
    
    init(response: URLResponse?) {
        guard let response = response as? HTTPURLResponse else {
            self = .unknown(nil)
            return
        }
        switch response.statusCode {
        case 400:
            self = .badRequest
        case 401:
            self = .notAuthenticated
        case 404:
            self = .notFound
        default:
            self = .unknown(response)
        }
    }
    
    var isAuthError: Bool {
        switch self {
        case .notAuthenticated: return true
        default: return false
        }
    }
    
    var description: String {
        switch self {
        case .notAuthenticated:
            return ErrorMessages.Default.NotAuthorized
        case .notFound:
            return ErrorMessages.Default.NotFound
        case .networkProblem, .unknown:
            return ErrorMessages.Default.ServerError
        case .requestFailed:
            return ErrorMessages.Default.RequestFailed
        case .badRequest:
            return ErrorMessages.Default.BadRequest
        case .invalidData:
            return ErrorMessages.Default.InvalidData
        }
    }
    
}

// MARK: - Constants

extension NetworkError {
    
    struct ErrorMessages {
        
        struct Default {
            static let ServerError = "Server Error"
            static let NotAuthorized = "This information is not available"
            static let NotFound = "Bad request error"
            static let RequestFailed = "Resquest failed"
            static let BadRequest = "Bad Request"
            static let InvalidData = "Invalid data"
        }
        
    }
    
}
