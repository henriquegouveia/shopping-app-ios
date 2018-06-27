//
//  AlamofireRequest+Decodable.swift
//  ShoppingApp
//
//  Created by Henrique Cesar Gouveia on 26/06/18.
//  Copyright © 2018 Henrique Gouveia. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
    func responseObject<T: Decodable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self {
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
            guard error == nil else { return .failure(CBClientError(response: response, data: data, error: error)) }

            guard let dataUnwrapped = data else {
                return .failure(CBClientError(response: response, data: data, error: error))
            }

            let decoder = JSONDecoder()
            guard let responseObject = try? decoder.decode(T.self, from: dataUnwrapped) else {
                return .failure(CBClientError(response: response, data: data, error: error))
            }

            return .success(responseObject)
        }

        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }

    func responseCollection<T: Decodable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<[T]>) -> Void)
        -> Self {
        let responseSerializer = DataResponseSerializer<[T]> { request, response, data, error in
            guard error == nil else { return .failure(CBClientError(response: response, data: data, error: error)) }

            let jsonSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonSerializer.serializeResponse(request, response, data, nil)

            guard case let .success(jsonObject) = result else {
                return .failure(CBClientError(response: response, data: data, error: error))
            }

            guard let responseUnwrapped = response else {
                return .failure(CBClientError(response: response, data: data, error: error))
            }
            
            guard let dataUnwrapped = data else {
                return .failure(CBClientError(response: response, data: data, error: error))
            }
            
            guard let responseObject = try? JSONDecoder().decode([T].self, from: dataUnwrapped) else {
                return .failure(CBClientError(response: response, data: data, error: error))
            }

            return .success(responseObject)
        }

        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
//}

// MARK: Response Serializable

//protocol ResponseCollectionSerializable {
//    static func collection(from response: HTTPURLResponse, withRepresentation representation: JSON) -> [Self]
//}

}
