//
//  ABIClientError.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import Alamofire

enum CBClientError: CustomErrorConvertible {    
    
    case Unknown(HTTPURLResponse?, Data?, CustomErrorConvertible)
    case SerializationError(CBSerializationError)
    case ServerError(CBServerError)
    case InternetConnectionError(CustomErrorConvertible)
    case AlamofireError(CustomErrorConvertible)
    
    init(response: HTTPURLResponse?, data: Data?, error: Error?) {
        if let _ = error as? Alamofire.AFError {
            if let serverError = CBServerError.serverErrorForResponse(response: response, data: data) {
                self = .ServerError(serverError)
                return
            }
        }
        
        if let decodedError = error as? DecodingError {
            var errorContext: DecodingError.Context
            
            switch decodedError {
            case .dataCorrupted(let context):
                errorContext = context
                break
            case .keyNotFound(_, let context):
                errorContext = context
                break
            case .typeMismatch(_, let context):
                errorContext = context
                break
            case .valueNotFound(_, let context):
                errorContext = context
            }
            
            self = .SerializationError(CBSerializationError(error: errorContext))
        } else {
            
            let localError = error as? CustomErrorConvertible
            
            if let _ = AlamofireErrorCode(rawValue: localError?.code ?? -1009) {
                self = .AlamofireError(localError!)
            } else {
                self = .Unknown(response, data, localError!)
            }
        }
    }
    
    var code: Int {
        switch self {
        case .Unknown: return 0
        case .SerializationError: return 1
        case .ServerError: return 2
        case .InternetConnectionError: return 3
        case .AlamofireError(_): return 4
        }
    }
    
    var domain: String {
        return "com.coolblue"
    }
    
    var childError: CustomErrorConvertible? {
        switch self {
        case .Unknown(_, _, let err): return err
        case .SerializationError(let err): return err
        case .ServerError(let err): return err
        case .InternetConnectionError(let err): return err
        case .AlamofireError(let err): return err
        }
    }
}

enum AlamofireErrorCode: Int {
    case InternetConnectionError = -1009
}

struct CBSerializationError: CustomErrorConvertible {
    
    init(error: DecodingError.Context) {
        self.description = error.debugDescription
        self.localizedFailureReason = error.debugDescription
        error.codingPath.forEach { (codekey) in
            self.userInfo[String(codekey.intValue ?? 0)] = codekey.debugDescription
        }
    }
    
    var domain: String {
        return "com.coolblue.servererror"
    }
    
    var code: Int {
        return -1
    }
    var localizedFailureReason: String?
    var description: String
    var userInfo: [String : Any] = [:]
}

