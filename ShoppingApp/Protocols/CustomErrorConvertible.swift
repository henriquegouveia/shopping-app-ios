//
//  CustomErrorConvertible.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import Alamofire

// swiftlint:disable variable_name
let userLocalizedErrorDescriptionKey: String = "UserLocalizedErrorDescriptionKey"
let userLocalizedErrorTitleKey: String = "UserLocalizedErrorTitleKey"
// swiftlint:enable variable_name

/**
 *  Handy protocol to deal with errors
 */
protocol CustomErrorConvertible: Error, CustomStringConvertible {
    
    var domain: String { get }
    var code: Int { get }

    // [Opcional]

    var userLocalizedTitle: String? { get }
    var localizedFailureReason: String? { get }
    var userInfo: [String : Any] { get }
    
    /// An NSError equivalent.
    var error: NSError { get }
    
    /// The child of this error, if any. If you are implementing this protocol in a enum and you have
    /// an associated error, return the associated error, otherwise, return nil.
    var childError: CustomErrorConvertible? { get }
}

extension CustomErrorConvertible {

    var userLocalizedTitle: String? {
        return nil
    }
    
    var localizedFailureReason: String? {
        return nil
    }
    
    var userInfo: [String : Any] {
        return [:]
    }
    
    var error: NSError {
        return NSError(domain: domain, code: code, userInfo: userInfo)
    }
    
    var description: String {
        return "\(domain), code: \(code), userInfo: \(userInfo)"
    }
}

extension CustomErrorConvertible {
    
    var childError: CustomErrorConvertible? {
        return nil
    }
    
    /**
     childError's recursion until nil.
     
     - returns: The root error.
     */
    func rootError() -> CustomErrorConvertible {
        return childError?.rootError() ?? self
    }
    
    func userLocalizedTitleUnwrapped() -> String {
        return userLocalizedTitle ?? "GenericErrorTitle"
    }

}
