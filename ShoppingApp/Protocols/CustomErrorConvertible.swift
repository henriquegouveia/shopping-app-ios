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
    
    // [Required]
    
    /// The error's domain.
    var domain: String { get }
    
    /// The error's code.
    var code: Int { get }

    // [Opcional]
    
    /// A localized and friendly title of this error. You can show this title to the user.
    var userLocalizedTitle: String? { get }
    
    /// A localized and friendly message of this error. You can show this message to the user.
    var userLocalizedMessage: String? { get }
    
    /// The failure reason of this error
    var localizedFailureReason: String? { get }
    
    /// The error's userInfo.
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
    
    var userLocalizedMessage: String? {
//        let json = JSON(userInfo)
//        if let data = json[ServerErrorJSONSchema.dataKey].dictionary, let message = data[ServerErrorJSONSchema.messageKey] {
//            return message.string
//        }
//        
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
    
    var childError: CustomErrorConvertible? {
        return nil
    }
    
    var description: String {
        return "\(domain), code: \(code), userInfo: \(userInfo)"
    }
}

extension CustomErrorConvertible {
    
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
    
    func userLocalizedMessageUnwrapped() -> String {
        return userLocalizedMessage ?? "GenericErrorMessage"
    }

}
