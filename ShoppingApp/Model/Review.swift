//
//  Review.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 02/07/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation

struct Review: Decodable {
    let reviewId: Int
    let description: String?
    let title: String
    let rating: Double
}