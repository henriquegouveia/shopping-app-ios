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

typealias SENDER = [String: Any]

// MARK: - View Controllers Protocols

protocol ProductDetailProtocol: class {
    var product: ProductDetail? { get }
    func showProductDetails(product: Product)
}

protocol SegueWithObservableSender: class {
    func observableDatasouce<T>(_ observable: Observable<[T]>)
}

protocol ProductPageProtocol: SegueWithObservableSender {
}

protocol ProductImageProtocol: class {
    var productImage: String { get set }
}

protocol RecommendationsProtocol: SegueWithObservableSender {
}

// MARK: - Product Mediator Implementation

struct ProductMediator: MediatorProtocol {
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ProductPageProtocol, let sender = sender as? SENDER {
            guard let observable = sender[String(describing: ProductPageProtocol.self)] as? Observable<[String]> else { return }
            destinationVC.observableDatasouce(observable)
        } else if let destinationVC = segue.destination as? RecommendationsProtocol, let sender = sender as? SENDER {
            guard let observable = sender[String(describing: RecommendationsProtocol.self)] as? Observable<[Int]> else { return }
            destinationVC.observableDatasouce(observable)
        }
    }
}
