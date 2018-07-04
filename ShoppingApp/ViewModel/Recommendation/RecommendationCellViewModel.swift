//
//  RecommendationCellViewModel.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 04/07/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import RxSwift

class RecommendationCellViewModel {
    private var _productId: Int
    private let _client = ProductClient()
    
    init(productId: Int) {
        self._productId = productId
    }
    
    // MARK: - Private Lets
    
    private let _isLoading = Variable(false)
    private let _error = PublishSubject<Error>()
    private let _price = Variable<String>("")
    private let _productImage = Variable<String>("")
    private let _disposeBag = DisposeBag()
    
    // MARK: - Public Vars
    
    var productImage: Observable<String> {
        return self._productImage.asObservable()
    }
    
    var price: Observable<String> {
        return self._price.asObservable()
    }
    
    func fetchProductDetails() {
        self._isLoading.value = true
        self._client?.getProductDetails(productId: self._productId).subscribe(onNext: { [weak self] (productDetail) in
            guard let weakSelf = self else { return }
            weakSelf._price.value = productDetail.product.salesPriceIncVat!.currency()
            weakSelf._productImage.value = productDetail.product.productImages!.first!
            weakSelf._isLoading.value = false
            }, onError: { (error) in
                self._error.onNext(error)
                self._isLoading.value = false
        }).disposed(by: self._disposeBag)
    }
    
}
