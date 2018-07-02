//
//  ProductPage.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation

struct ProductList: Decodable {
    let currentPage: Int = 0
    let pageSize: Int = 0
    let totalResults: Int = 0
    let pageCount: Int = 0
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
        
        init(id: Int) {
            productId = id
            productName = "henrique \(productId)"
            availabilityState = 0
            productImage = ""
            coolbluesChoiceInformationTitle = ""
            especifications = ["gouveia"]
        }
        
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
