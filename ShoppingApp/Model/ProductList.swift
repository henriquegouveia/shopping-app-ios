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
}
