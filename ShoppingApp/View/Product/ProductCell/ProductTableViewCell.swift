//
//  ProductTableViewCell.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 27/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    override var reuseIdentifier: String? {
        return "ProductTableViewCell"
    }
}

// MARK: - ProductCell Implemenation

extension ProductTableViewCell: ProductCellProtocol {
    func loadData(product: ProductViewModel) {
        self.productName.text = product.productName
        self.productDescription.text = product.productDescription
        self.productImageView.image = product.productImage
    }
}
