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
        case genericError
        case alamofire(_ error: AFError, _ data: Data?)
        case decodeError(_ error: Error)
        case errorWithMessage(_ message: String)
    }
    
    func request<ResponseObject: Decodable>(
        _ urlRequest: URLRequestConvertible
    ) -> AnyPublisher<ResponseObject, ResponseError> {
        return AF.request(urlRequest)
            .validate()
            .publishData()
            .tryMap(mapResponseError)
            .eraseToAnyPublisher()
            .map { data in
                guard let data = data, !data.isEmpty else {
                    return "{}".data(using: .utf8) ?? Data()
                }
                return data
            }
            .decode(type: ResponseObject.self, decoder: JSONDecoder())
            .mapError { (error) -> ResponseError in
                if let error = error as? ResponseError {
                    return error
                }
                return ResponseError.decodeError(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func mapResponseError(_ response: DataResponse<Data, AFError>) throws -> Data? {
        if response.error != nil {
            try handleResponseError(response)
        }
        return response.data
    }

    private func handleResponseError(_ response: DataResponse<Data, AFError>) throws {
        guard let error = response.error else { return }
        throw ResponseError.alamofire(error, response.data)
    }
}
