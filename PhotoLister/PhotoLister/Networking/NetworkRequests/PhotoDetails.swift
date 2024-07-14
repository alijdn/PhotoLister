//
//  PhotoDetails.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 14/07/2024.
//

import Foundation
import Alamofire

struct PhotoDetailsRequest: URLRequestConvertible {
    private let apiKey = "255429a5b00649776b8bd9be7fd216d8"
    private let baseURL = "https://api.flickr.com/services/rest/"
    let photoId: String
    
    func asURLRequest() throws -> URLRequest {
        let parameters: [String: String] = [
            "api_key": apiKey,
            "method": "flickr.photos.getInfo",
            "format": "json",
            "safe_search": "1",
            "nojsoncallback": "1",
            "photo_id": photoId,
        ]
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .get
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        
        print("URL Request: \(urlRequest)")
        return urlRequest
    }
}
