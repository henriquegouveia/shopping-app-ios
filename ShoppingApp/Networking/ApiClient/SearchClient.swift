//
//  ProductClient
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol SearchClientType: CBClientType {
    func getProducts(page: Int, query: String) -> Observable<ProductList>
}

extension SearchClientType {
    func getProducts(page: Int, query: String) -> Observable<ProductList> {
        return Observable.create({ (observer) -> Disposable in
            let route = Router.getProducts(page: page, query: query)
            let request = self.sendRequestWithRoute(route: route) { (result: Result<ProductList>) in
                switch result {
                case .success(let productsList):
                    observer.onNext(productsList)
                    observer.onCompleted()
                    break
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        })
    }
}

class SearchClient: HTTPClient, SearchClientType { }

//MARK: Route

private enum Router: HTTPRouteConvertible {
    case getProducts(page: Int, query: String)
    
    var route: HTTPRoute {
        switch self {
        case .getProducts(let page, let query):
            return HTTPRoute(path: "/search",
                             params: ["query": query,
                                      "page": page],
                             method: .get,
                             encoding: URLEncoding.default)
        }
    }
}
