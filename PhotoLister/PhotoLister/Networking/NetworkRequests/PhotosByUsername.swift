//
//  PhotosByUsername.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 14/07/2024.
//

import Foundation
import Alamofire

struct PhotosByUsernameRequest: URLRequestConvertible {
    let username: String
    
    func asURLRequest() throws -> URLRequest {
        let parameters: [String: String] = [
            "api_key": AppConfig.shared.apiKey,
            "method": "flickr.people.getPhotos",
            "format": "json",
            "nojsoncallback": "1",
            "safe_search": "1",
            "user_id": username,
            "per_page": "10"
        ]
        let url = try AppConfig.shared.baseURL.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .get
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        return urlRequest
    }
}
