//
//  ProductTableViewCell.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 27/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import UIKit
import RxNuke
import Nuke
import RxSwift

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    private let disposeBag = DisposeBag()
    
    override var reuseIdentifier: String? {
        return "ProductTableViewCell"
    }
    
    // MARK: - Private Functions
    
    private func loadImageFromURL(_ url: URL) {
        ImagePipeline.shared.rx.loadImage(with: url)
            .subscribe(onSuccess: { self.productImageView.image = $0.image })
            .disposed(by: disposeBag)
    }
}

// MARK: - ProductCell Implemenation

extension ProductTableViewCell: ProductCellProtocol {
    func loadData(product: Product) {
        self.imageView?.image = nil
        
        self.productName.text = product.productName
        self.productDescription.text = product.salesPriceIncVat?.currency()
        if let imageURL = product.productImage, let url = URL(string: imageURL) {
            self.loadImageFromURL(url)
        }
    }
}
