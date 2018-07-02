//
//  ProductClient.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 29/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol ProductClientType: CBClientType {
    func getProductDetails(productId: Int) -> Observable<ProductDetail>
}

extension ProductClientType {
    func getProductDetails(productId: Int) -> Observable<ProductDetail> {
        return Observable.create({ (observer) -> Disposable in
            let route = Router.getProductDetail(productId: productId)
            let request = self.sendRequestWithRoute(route: route, completion: { (result: Result<ProductDetail>) in
                switch result {
                case .success(let productDetails):
                    observer.onNext(productDetails)
                    observer.onCompleted()
                    break
                case .failure(let error):
                    observer.onError(error)
                }
            })
            return Disposables.create {
                request.cancel()
            }
        })
    }
}

class ProductClient: HTTPClient, ProductClientType { }

private enum Router: HTTPRouteConvertible {
    case getProductDetail(productId: Int)
    
    var route: HTTPRoute {
        switch self {
        case .getProductDetail(let productId):
            return HTTPRoute(path: "/product/\(productId)",
                params: nil,
                method: .get,
                encoding: JSONEncoding.default)
        }
    }
}
