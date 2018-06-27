//
//  ProductViewModel.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 27/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import UIKit

struct ProductViewModel {
    let productName: String
    let productDescription: String
    var productImage: UIImage?
}

extension ProductViewModel {
    init(product: ProductList.Product) {
        self.productName = product.productName
        let strings = product.especifications.map { (especification) -> String in
            guard let string = especification else { return "" }
            return string + "\n"
        }
        
        self.productDescription = strings.joined()
    }
}
