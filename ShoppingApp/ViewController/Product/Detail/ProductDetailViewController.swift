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
    private let _disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindFields()
    }
    
    private var customView: ProductDetailView {
        return self.view as! ProductDetailView
    }
    
    // MARK: - Private Functions
    
    private func bindFields() {
        self._viewModel.productName.bind(to: self.customView.productNameLabel.rx.text).disposed(by: self._disposeBag)
        self._viewModel.productText.bind(to: self.customView.productTextLabel.rx.text).disposed(by: self._disposeBag)
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
