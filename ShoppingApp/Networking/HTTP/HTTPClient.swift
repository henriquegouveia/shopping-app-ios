//
//  ABIClient.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation

public class HTTPClient: CBClientType {
    weak var delegate: CBClientDelegate?
    
    public init?() {
        
    }
    
    lazy var manager: HTTPManager = {
        var headerValues = ["Content-Type": "application/json"]
        return HTTPManager(extraHeaders: headerValues)
    }()
    
    func managerForRoute(route: HTTPRouteConvertible) -> HTTPManager {
        return manager
    }
    
}
