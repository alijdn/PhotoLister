//
//  NetworkManager.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 12/07/2024.
//

import Foundation
import Combine
import Alamofire

final class NetworkManager {
    
    enum ResponseError: Error {
        case emptyResponse
        case decodeError(Error)
    }
    
    func request<T: Decodable>(_ urlRequest: URLRequestConvertible) -> AnyPublisher<T, ResponseError> {
        return AF.request(urlRequest)
            .validate()
            .publishData()
            .tryMap { response in
                guard let data = response.data else {
                    throw ResponseError.emptyResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let responseError = error as? ResponseError {
                    return responseError
                } else {
                    return ResponseError.decodeError(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
