//
//  HTTPRoute.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import Alamofire

struct HTTPRoute {
    let path: String
    let params: Parameters?
    let method: HTTPMethod
    let encoding: ParameterEncoding
}
