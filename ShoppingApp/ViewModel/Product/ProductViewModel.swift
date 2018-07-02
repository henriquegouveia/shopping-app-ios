//
//  ProductViewModel.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 27/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import RxSwift

class ProductViewModel {
    private var _product: ProductList.Product?
    private var _productDetail: ProductDetail?
    private let _client = ProductClient()
    private let _disposeBag = DisposeBag()
    
    var productDetail: ProductDetail? {
        return self._productDetail
    }
    
    // MARK: - Public Functions
    
    func updateProduct(product: ProductList.Product) {
        self._product = product
        self.fetchProductDetails()
    }
    
    private func fetchProductDetails() {
        guard let product = self._product else { return }
        self._client?.getProductDetails(productId: product.productId).subscribe(onNext: { (productDetail) in
            print(productDetail)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("disposed")
        }).disposed(by: self._disposeBag)
    }
}

extension ProductViewModel {
    
}
