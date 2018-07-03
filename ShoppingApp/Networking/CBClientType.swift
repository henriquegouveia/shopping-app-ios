//
//  ABIClientType.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Alamofire

typealias ProductsClientResult = ((Result<ProductList>)->Void)
typealias ProductClientResult = ((Result<ProductList>)->Void)

typealias HTTPManager = SessionManager

protocol CBClientType: class {
    func managerForRoute(route: HTTPRouteConvertible) -> HTTPManager
    
    var delegate: CBClientDelegate? { get set }
}

extension CBClientType {
    func sendRequestWithRoute<T: Decodable>(route: HTTPRouteConvertible,
                              completion: @escaping (Result<T>) -> Void) -> DataRequest {
        return self.request(route: route).responseObject(completionHandler: { (response: DataResponse<T>) in
                let result = mapResponse(res: response)
                self.verifyResult(result: result, request: response.request)
                completion(result)
            })
    }
    
    func sendRequestWithRouteForArray<T: Decodable>(route: HTTPRouteConvertible,
                                                                     completion: @escaping (Result<[T]>) -> Void) -> DataRequest {
        return self.request(route: route).responseCollection(completionHandler: { (response: DataResponse<[T]>) in
            let result = mapCollectionResponse(res: response)
            print(result)
        })
    }

    private func verifyResult<T>(result: Result<T>, request: URLRequest?) {
        if let error = result.error as? CBClientError {
            self.notifyAboutError(error: error, request: request)
        }
    }
    
    private func request(route: HTTPRouteConvertible) -> DataRequest {
        return managerForRoute(route: route).request(route).validate()
    }
    
    private func notifyAboutError(error: CBClientError, request: URLRequest?) {
        self.delegate?.abiClient(client: self, gotError: error, forRequest: request)
    }
}

private func mapResponse<T: Decodable>(res: DataResponse<T>) -> Result<T> {
    switch res.result {
    case .success(let value):
        return .success(value)
    case .failure(let error):
        return .failure(CBClientError(response: res.response, data: res.data, error: error))
    }
}

private func mapCollectionResponse<T: Decodable>(res: DataResponse<[T]>) -> Result<[T]> {
    switch res.result {
    case .success(let value):
        return .success(value)
    case .failure(let error):
        return .failure(CBClientError(response: res.response, data: res.data, error: error))
    }
}
