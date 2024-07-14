//
//  PhotoDetails.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 14/07/2024.
//

import Foundation
import Alamofire

struct PhotoDetailsRequest: URLRequestConvertible {
    let photoId: String
    
    func asURLRequest() throws -> URLRequest {
        let parameters: [String: String] = [
            "api_key": AppConfig.shared.apiKey,
            "method": "flickr.photos.getInfo",
            "format": "json",
            "safe_search": "1",
            "nojsoncallback": "1",
            "photo_id": photoId,
        ]
        let url = try AppConfig.shared.baseURL.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .get
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        return urlRequest
    }
}
