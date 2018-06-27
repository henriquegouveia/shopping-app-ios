//
//  ProductClient
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import Alamofire

protocol ProductClientType: CBClientType {
    func getProducts(page: Int, completion: @escaping ProductsClientResult) -> Request
}

extension ProductClientType {
    func getProducts(page: Int, completion: @escaping ProductsClientResult) -> Request {
        let route = Router.getProducts(page: page)
        return sendRequestWithRoute(route: route) { (value: Result<ProductList>) in
            completion(value)
        }
    }
}

class ProductClient: HTTPClient, ProductClientType { }

//MARK: Route

private enum Router: HTTPRouteConvertible {
    case getProducts(page: Int)
    
    var route: HTTPRoute {
        switch self {
        case .getProducts(let page):
            return HTTPRoute(path: "/search",
                             params: ["query": "apple",
                                      "page": page],
                             method: .get,
                             encoding: URLEncoding.default)
        }
    }
}
