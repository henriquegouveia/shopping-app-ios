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
        let availabilityState: Int?
        let salesPriceIncVat: Double?
        let salesPriceExVat: Double?
        let productImage: String?
        let coolbluesChoiceInformationTitle: String?
        let nextDayDelivery: Bool?
        var specifications = [String?]()
        let productText: String?
        var reviewInformation: ReviewInformation?
        var pros: [String?]?
        var cons: [String?]?
        var productImages: [String?]?
        var deliveredWith: [String?]?
        var specificationSummary: [Specification?]?
        var recommendedAccessories: [Int]?
        
        struct Specification: Decodable {
            let name: String?
            let stringValue: String?
        }
        
        struct ReviewInformation: Decodable {
            var reviews: [Review?]?
            
            struct Review: Decodable {
                let reviewId: Int
                let description: String?
                let title: String
                let rating: Double
            }
        }
        
        enum CodingKeys : String, CodingKey {
            case productId
            case productName
            case availabilityState
            case salesPriceIncVat
            case salesPriceExVat
            case productImage
            case coolbluesChoiceInformationTitle
            case nextDayDelivery
            case specifications = "USPs"
            case productText
            case reviewInformation
            case pros
            case cons
            case productImages
            case deliveredWith
            case specificationSummary
            case recommendedAccessories
        }
    }
}
