//
//  ProductListViewModel.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 27/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation

struct ProductListViewModel {
    let title = "Products"
    
    internal var apiProvider: HTTPClient?
    
    var currentPage = 0
    var totalPages = 0
    var products = [ProductViewModel]()
}

extension ProductListViewModel {
    init(apiProvider: HTTPClient) {
        self.apiProvider = apiProvider
    }
    
}
