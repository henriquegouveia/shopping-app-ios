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
    
    // MARK: - Private Vars
    
    private var _product: Product? {
        didSet {
            self.updateBasicProductInformation()
        }
    }
    
    private var _productDetail: ProductDetail?
    private let _client = ProductClient()
    
    
    // MARK: - Private Lets
    
    private let _isLoading = Variable(false)
    private let _error = PublishSubject<Error>()
    private let _productName = Variable<String>("")
    private let _price = Variable<String>("")
    private let _productText = Variable<String>("")
    private let _deliveredWith = Variable<String>("")
    private let _hideNextDayDelivery = Variable(false)
    private let _disposeBag = DisposeBag()
    
    // MARK: - Public vars
    
    var productDetail: ProductDetail? {
        return self._productDetail
    }
    
    var productName: Observable<String> {
        return self._productName.asObservable()
    }
    
    var price: Observable<String> {
        return self._price.asObservable()
    }
    
    var productText: Observable<String> {
        return self._productText.asObservable()
    }
    
    var deliveredWith: Observable<String> {
        return self._deliveredWith.asObservable()
    }
    
    var hideNextDayDelivery: Observable<Bool> {
        return self._hideNextDayDelivery.asObservable()
    }
    
    // MARK: - Private Functions
    
    private func fetchProductDetails() {
        guard let product = self._product else { return }
        self._client?.getProductDetails(productId: product.productId).subscribe(onNext: { [weak self] (productDetail) in
            guard let weakSelf = self else { return }
            weakSelf.updateProductDetailsInformation(product: productDetail.product)
        }, onError: { (error) in
            self._error.onNext(error)
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("disposed")
        }).disposed(by: self._disposeBag)
    }
    
    private func updateBasicProductInformation() {
        guard let product = self._product else { return }
        self._productName.value = product.productName
        self._price.value = product.salesPriceIncVat?.currency() ?? ""
        self._hideNextDayDelivery.value = product.nextDayDelivery
    }
    
    private func updateProductDetailsInformation(product: Product) {
        self._productText.value = product.productText ?? ""
        self._deliveredWith.value = self.formattedDeliveryWith(deliveredWith: product.deliveredWith)
    }
    
    private func formattedDeliveryWith(deliveredWith: [String?]?) -> String {
        guard let delivredWith = deliveredWith else { return "" }
        let string = delivredWith.compactMap{$0}.joined(separator: "\n")
        return string
    }
    
    // MARK: - Public Functions
    
    func updateProduct(product: Product) {
        self._product = product
        self.fetchProductDetails()
    }
}

extension ProductViewModel {
    
}
