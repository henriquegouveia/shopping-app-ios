//
//  XCTest+Utils.swift
//  ShoppingAppTests
//
//  Created by Henrique Cesar Gouveia on 03/07/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import XCTest
@testable import ShoppingApp

extension Bundle {
    func loadData(resource: String, type: String) -> Data {
        let path = self.path(forResource: resource, ofType: type)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        return data!
    }
}
