//
//  ShoppingAppTests.swift
//  ShoppingAppTests
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import XCTest
@testable import ShoppingApp

class ProductDetailsTests: XCTestCase {
    
    private var _data: Data!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: type(of: self))
        _data = bundle.loadData(resource: "product-0", type: "json")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: Testable Functions
    
    func testProductDetailsParser() {
        let result = try? JSONDecoder().decode(ProductDetail.self, from: self._data)
        XCTAssertNotNil(result, "Object can not be nil")
        XCTAssertNotNil(result?.product, "Product can not be nil")
        let product = result?.product
        
        XCTAssertTrue(product?.productId == 785359, "The product Id must be Int type")
        XCTAssertNotNil(product?.productText, "ProductText can Not be nil")
    }
    
    func testProductListParser() {
        
    }
}
