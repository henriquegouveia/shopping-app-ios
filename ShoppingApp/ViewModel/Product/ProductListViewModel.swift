//
//  ProductListViewModel.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 27/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProductListViewModel {
    
    // MARK: Internal Vars
    
    internal var currentPage: Int = 1
    internal var totalPages: Int = 1
    internal let client = SearchClient()
    internal let disposedBag = DisposeBag()
    
    // MARK: Private Properties
    
    private let _products = Variable<[ProductList.Product]>([])
    private let _isLoading = Variable(false)
    private let _error = PublishSubject<Error>()
    
    // MARK: Public Vars
    
    var products: Observable<[ProductList.Product]> {
        return self._products.asObservable()
    }
    var isLoading: Observable<Bool> {
        return self._isLoading.asObservable()
    }
    var error: Observable<Error> {
        return self._error.asObservable()
    }
    
    let title = "Products"
    
    // MARK: - Constructors
    
    init() {
        self.getProducts(query: "all")
    }
    
    // MARK: - Private Functions
    
    private func updateViewModel(productList: ProductList) {
        self.currentPage = productList.currentPage
        self.totalPages = productList.pageCount
    }
    
    // MARK: - Public Functions
    
    func getProducts(query: String) {
        self._isLoading.value = true
        self.client?.getProducts(page: self.currentPage, query: query).subscribe(onNext: { (productList) in
            self._products.value.append(contentsOf: productList.products)
        }, onError: { (error) in
            //TODO Handle error
        }, onCompleted: {
            //TODO Handle the completed state
        }).disposed(by: self.disposedBag)
    }
}
