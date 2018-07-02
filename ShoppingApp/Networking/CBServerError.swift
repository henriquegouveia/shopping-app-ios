//
//  ABIServerError.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Alamofire

enum CBServerErrorCode: Int {
    case BadRequest = 400
    case InvalidUserOrPassword = 401
    case Forbidden = 403
    case NotFound = 404

    var description: String {
        return ""
    }

    var message: String {
        switch self {
        case .BadRequest: return "\(rawValue) (BadRequest)"
        case .InvalidUserOrPassword: return "\(rawValue) (InvalidUserOrPassword)"
        case .Forbidden: return "\(rawValue) (Forbidden)"
        case .NotFound: return "\(rawValue) (NotFound"
        }
    }
}

struct CBServerError: CustomErrorConvertible {
    
    let statusCode: CBServerErrorCode
    let data: [String : Any]?
    
    var domain: String {
        return "com.coolblue.servererror"
    }
    
    var code: Int {
        if let data = data {
            if let code = data[ServerErrorJSONSchema.codeKey] as? Int {
                return code
            }
        }
        
        return 0
    }
    
    var description: String {
        if let data = data {
            if let message = data[ServerErrorJSONSchema.messageKey] as? String {
                return message
            }
        }
        
        return "Unexpected Error"
    }
    
    var userInfo: [String : Any] {
        return [
            ServerErrorJSONSchema.responseCodeKey : statusCode.description as AnyObject,
            ServerErrorJSONSchema.dataKey : data ?? [:]
        ]
    }
    
    static func serverErrorForResponse(response: HTTPURLResponse?, data: Data?) -> CBServerError? {
        if let response = response {
            guard let code = CBServerErrorCode(rawValue: response.statusCode) else { return nil }
            
            let JSONResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = JSONResponseSerializer.serializeResponse(nil, response, data, nil)
            
            switch result {
            case .success(let value):
                return CBServerError(statusCode: code, data: value as? [String : Any])
            case .failure:
                return CBServerError(statusCode: code, data: nil)
            }
        }
        
        return nil
    }
}

struct ServerErrorJSONSchema {
    static let dataKey = "data"
    static let responseCodeKey = "httpResponseCode"
    static let codeKey = "code"
    static let messageKey = "message"
}
