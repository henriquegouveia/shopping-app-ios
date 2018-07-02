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
    
    private var _allProducts = [Product]()
    private let _products = Variable<[Product]>([])
    private let _filteredProducts = Variable<[Product]>([])
    private let _isLoading = Variable(false)
    private let _isFiltering = Variable(false)
    private let _error = PublishSubject<Error>()
    
    // MARK: Public Vars
    
    var products: Observable<[Product]> {
        return self._products.asObservable()
    }
    
    var isLoading: Observable<Bool> {
        return self._isLoading.asObservable()
    }
    
    var error: Observable<Error> {
        return self._error.asObservable()
    }
    
    let title = NSLocalizedString("Products", comment: "")
    
    // MARK: - Constructors
    
    init() {
        self.getProducts(query: "all")
    }
    
    // MARK: - Private Functions
    
    private func updateViewModel(productList: ProductList) {
        self.currentPage = productList.currentPage
        self.totalPages = productList.pageCount
    }
    
    private func filter(query: String) {
        self._isFiltering.value = true
        if (query.isEmpty) {
            self._products.value = self._allProducts;
        } else {
            let result = self._allProducts.filter{ return $0.productName.lowercased().contains(query.lowercased()) }
            self._products.value = result
        }
    }
    
    // MARK: - Public Functions
    
    func filterProducts(query: String) {
        self.filter(query: query)
    }
    
    func getProducts(query: String) {
        self._isLoading.value = true
        self.client?.getProducts(page: self.currentPage, query: query).subscribe(onNext: { (productList) in
            self._allProducts.append(contentsOf: productList.products)
            self._products.value.append(contentsOf: productList.products)
            self.currentPage += 1
        }, onError: { (error) in
            self._error.onNext(error)
        }, onCompleted: {
            self._isLoading.value = false
        }).disposed(by: self.disposedBag)
    }
}
