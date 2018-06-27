//
//  ProductPage.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation

struct ProductList: Decodable {
    let currentPage: Int
    let pageSize: Int
    let totalResults: Int
    let pageCount: Int
    var products = [Product]()
    
    struct Product: Decodable {
        let productId: Int
        let productName: String
        let availabilityState: Int
        let salesPriceIncVat: Int = 0
        let productImage: String?
        let coolbluesChoiceInformationTitle: String?
        let nextDayDelivery: Bool = false
        var especifications = [String?]()
        
            enum CodingKeys : String, CodingKey {
                case productId
                case productName
                case availabilityState
                case salesPriceIncVat
                case productImage
                case coolbluesChoiceInformationTitle
                case nextDayDelivery
                case especifications = "USPs"
            }
    }
}
