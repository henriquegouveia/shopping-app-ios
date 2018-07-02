//
//  HTTPRouteConvertible.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import Alamofire

protocol HTTPRouteConvertible: URLRequestConvertible, HTTPBaseURL {
    var route: HTTPRoute { get }
}

extension HTTPRouteConvertible {
    var baseURLPath: String {
        return "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/ios-assignment"
    }
}

extension HTTPRouteConvertible {

    func asURLRequest() throws -> URLRequest {
        let url = try baseURLPath.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(route.path))
        urlRequest.httpMethod = route.method.rawValue
        urlRequest = try route.encoding.encode(urlRequest, with: route.params)

        return urlRequest
    }
}
