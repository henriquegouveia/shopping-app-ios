//
//  ProductListViewModel.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 27/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import RxSwift

class ProductListViewModel {
    
    // MARK: private Vars
    
    private var _currentPage: Int = 1
    private var _totalPages: Int = 1
    private let _client = SearchClient()
    private let _disposedBag = DisposeBag()
    private var _isTotalPagesAchieved: Bool {
        return _currentPage > _totalPages
    }
    
    // MARK: Private Properties
    
    private var _allProducts = [Product]()
    private let _products = Variable<[Product]>([])
    private let _filteredProducts = Variable<[Product]>([])
    private let _isFiltering = Variable(false)
    private let _isLoading = Variable(false)
    private let _error = PublishSubject<Error>()
    
    // MARK: Constructors
    
    init(productList: ProductList) {
        self._totalPages = productList.pageCount
        self.updateDataSource(productList: productList)
    }
    
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
    
    var endIndex: Int {
        return (self._products.value.count - 1)
    }
    
    let title = NSLocalizedString("Products", comment: "")
    
    // MARK: - Constructors
    
    init() {
        self.getProducts(query: "all")
    }
    
    // MARK: - Private Functions
    
    private func updateViewModel(productList: ProductList) {
        self._currentPage = productList.currentPage
        self._totalPages = productList.pageCount
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
    
    private func updateDataSource(productList: ProductList) {
        self._totalPages = productList.pageCount
        self._allProducts.append(contentsOf: productList.products)
        self._products.value.append(contentsOf: productList.products)
    }
    
    // MARK: - Public Functions
    
    func didEndSearching() {
        self._products.value = self._allProducts
    }
    
    func filterProducts(query: String) {
        self.filter(query: query)
    }
    
    func getProducts(query: String = "") {
        if (_isTotalPagesAchieved) { return }
        
        self._isLoading.value = true
        self._client?.getProducts(page: self._currentPage, query: query).subscribe(onNext: { [weak self] (productList) in
            guard let weakSelf = self else { return }
            weakSelf.updateDataSource(productList: productList)
            weakSelf._currentPage += 1
        }, onError: { (error) in
            self._error.onNext(error)
        }, onCompleted: {
            self._isLoading.value = false
        }).disposed(by: self._disposedBag)
    }
}
