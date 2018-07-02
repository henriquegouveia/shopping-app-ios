//
//  ProductDetailViewController.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    private let _viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ProductDetailViewController: ProductDetailProtocol {
    var product: ProductDetail? {
        return self._viewModel.productDetail
    }
    
    func showProductDetails(product: ProductList.Product) {
        self._viewModel.updateProduct(product: product)
    }
}
