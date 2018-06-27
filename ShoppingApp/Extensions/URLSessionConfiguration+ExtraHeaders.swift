//
//  URLSessionConfiguration+ExtraHeaders.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import Alamofire

extension URLSessionConfiguration {
    static func createWithExtraHeaders(extraHeaders: [String : String] = [:]) -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default

        var headers = SessionManager.defaultHTTPHeaders

        for (key, value) in extraHeaders {
            headers[key] = value
        }

        configuration.httpAdditionalHeaders = headers
        return configuration
    }
}
