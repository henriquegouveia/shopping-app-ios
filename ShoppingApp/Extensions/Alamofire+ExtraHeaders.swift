//
//  Alamofire+ExtraHeaders.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import Alamofire

extension SessionManager {
    convenience init(extraHeaders: [String : String]?) {
        let extraHeaders = extraHeaders ?? [:]
        let configuration = URLSessionConfiguration.createWithExtraHeaders(extraHeaders: extraHeaders)
        self.init(configuration: configuration)
    }
}
