//
//  RecommendationListViewModel.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 04/07/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import RxSwift

struct RecommendationListViewModel {
    
    // MARK: - Private Vars
    
    private let _error = PublishSubject<Error>()
    private let _dataSource = Variable<[Int]>([])
    
    // MARK: Public Vars
    
    var dataSource: Observable<[Int]> {
        return self._dataSource.asObservable()
    }
    
    // MARK: - Constructors
    
    init(recommendations: [Int]) {
        self._dataSource.value = recommendations
    }
    
}
