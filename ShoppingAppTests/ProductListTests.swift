//
//  ProductListTests.swift
//  ShoppingAppTests
//
//  Created by Henrique Cesar Gouveia on 03/07/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import XCTest
import RxSwift
@testable import ShoppingApp

class ProductListTests: XCTestCase {
    
    private var _data: Data!
    private var _viewModel: ProductListViewModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.setupDataSource()
        self.setupViewModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Private Functions
    
    private func setupDataSource() {
        let bundle = Bundle(for: type(of: self))
        _data = bundle.loadData(resource: "product-list-0", type: "json")
    }
    
    private func setupViewModel() {
        let result = try? JSONDecoder().decode(ProductList.self, from: self._data)
        self._viewModel = ProductListViewModel(productList: result!)
    }
    
    // MARK: - Testable Functions
    
    func testProductListParser() {
        let result = try? JSONDecoder().decode(ProductList.self, from: self._data)
        XCTAssertNotNil(result, "Product List Parse Failed")
        XCTAssertGreaterThan(result!.products.count, 0)
    }
    
    func testProductListFilter() {
        let disposeBag = DisposeBag()
        self._viewModel.filterProducts(query: "iPhone X")
        self._viewModel.products.subscribe(onNext: { (products) in
            XCTAssertEqual(products.count, 3)
        }, onError: { (error) in
            XCTAssert(true, error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
