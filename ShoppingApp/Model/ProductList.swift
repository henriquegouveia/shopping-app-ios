//
//  ProductPage.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation

struct ProductList: Decodable {
    var currentPage: Int
    var pageSize: Int
    var totalResults: Int
    var pageCount: Int = 0
    var products = [Product]()
}
