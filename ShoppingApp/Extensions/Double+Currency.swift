//
//  Double+Currency.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 02/07/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation

extension Double {
    func currency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: Locale.current.identifier)
        let result = formatter.string(from: self as NSNumber)
        return result!
    }
}
