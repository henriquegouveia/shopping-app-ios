//
//  ProductDetail.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 29/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation

struct ProductDetail: Decodable {
    let description: String
    let productText: String
    let pros = [String?]()
    let cons = [String?]()
    let productImages = [String?]()
    let recommendedAccessories = [String?]()
    let deliveredWith = [String?]()
    let salesPriceExVat: Double
    let specificationSummary = [Specification]()
    
    struct Specification: Decodable {
        let name: String
        let value: String
    }
}
