//
//  ProductMediator.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 01/07/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import UIKit

protocol ProductDetailProtocol {
    var product: ProductList.Product? { get set }
}

struct ProductMediator: MediatorProtocol {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}