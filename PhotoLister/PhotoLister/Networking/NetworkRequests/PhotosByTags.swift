//
//  PhotosByTags.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 13/07/2024.
//

import Foundation
import Alamofire

struct PhotosByTagsRequest: URLRequestConvertible {
    let tags: String
    
    func asURLRequest() throws -> URLRequest {
        let parameters: [String: String] = [
            "api_key": AppConfig.shared.apiKey,
            "method": "flickr.photos.search",
            "format": "json",
            "nojsoncallback": "1",
            "safe_search": "1",
            "tags": tags
        ]
        let url = try AppConfig.shared.baseURL.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .get
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        return urlRequest
    }
}
