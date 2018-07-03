//
//  ProductMediator.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 01/07/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol ProductDetailProtocol: class {
    var product: ProductDetail? { get }
    func showProductDetails(product: Product)
}

protocol ProductPageProtocol: class {
    func observableDatasouce(_ observable: Observable<[String]>)
}

protocol ProductImageProtocol: class {
    var productImage: String { get set }
}

struct ProductMediator: MediatorProtocol {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ProductPageProtocol, let observable = sender as? Observable<[String]> {
            destinationVC.observableDatasouce(observable)
        }
    }
}
