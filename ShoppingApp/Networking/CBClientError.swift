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
    case SerializationError(CustomErrorConvertible)
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

        let error = error as! CustomErrorConvertible
       
        if let _ = AlamofireErrorCode(rawValue: error.code) {
            self = .AlamofireError(error)
        } else {
            self = .Unknown(response, data, error)
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
        return "com.abi"
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
