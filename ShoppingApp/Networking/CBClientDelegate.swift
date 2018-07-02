//
//  ABIClientDelegate.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation

protocol CBClientDelegate: class {
    func abiClient(client: CBClientType,
        gotError error: CBClientError,
        forRequest request: URLRequest?)
}
