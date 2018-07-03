//
//  ProductDetailViewController.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductDetailViewController: UIViewController {

    private let _viewModel = ProductViewModel()
    private let _mediator = ProductMediator()
    private let _disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindFields()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let a = "https://upload.wikimedia.org/wikipedia/commons/3/32/House_sparrow04.jpg"
        let b = "https://www.allaboutbirds.org/sgapp/images/shape/icon-blackbirds.png"
        self._mediator.prepare(for: segue, sender: [a,b])
    }
    
    // MARK: - Private Functions
    
    private var customView: ProductDetailView {
        return self.view as! ProductDetailView
    }
    
    
    private func bindFields() {
        self._viewModel.productName.bind(to: self.customView.productNameLabel.rx.text).disposed(by: self._disposeBag)
        self._viewModel.productText.bind(to: self.customView.productTextLabel.rx.text).disposed(by: self._disposeBag)
        self._viewModel.price.bind(to: self.customView.priceLabel.rx.text).disposed(by: self._disposeBag)
        self._viewModel.deliveredWith.bind(to: self.customView.deliveredWithLabel.rx.text).disposed(by: self._disposeBag)
        self._viewModel.hideNextDayDelivery.bind(to: self.customView.nextDayDeliveryImageView.rx.isHidden).disposed(by: self._disposeBag)
    }

}

extension ProductDetailViewController: ProductDetailProtocol {
    var product: ProductDetail? {
        return self._viewModel.productDetail
    }
    
    func showProductDetails(product: Product) {
        self._viewModel.updateProduct(product: product)
    }
}
