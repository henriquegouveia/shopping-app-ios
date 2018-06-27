//
//  ProductDetailViewController.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import UIKit

protocol ProductDetailProtocol {
    var product: ProductList.Product? { get set }
}

class ProductDetailViewController: UIViewController, ProductDetailProtocol {

    var product: ProductList.Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
