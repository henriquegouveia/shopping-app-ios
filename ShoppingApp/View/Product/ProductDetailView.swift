//
//  ProductDetailView.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 02/07/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailView: UIView {
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productTextLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deliveredWithLabel: UILabel!
    @IBOutlet weak var nextDayDeliveryImageView: UIImageView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
}
