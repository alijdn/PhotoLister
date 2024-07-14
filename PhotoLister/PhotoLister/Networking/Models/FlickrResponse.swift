//
//  FlickrResponse.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 12/07/2024.
//

import Foundation

struct FlickrResponse: Codable {
    let photos: Photos
}

struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
}

struct Photo: Hashable, Identifiable, Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
    
    var photoURL: URL {
            URL(string: "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg")!
        }
    var userIconURL: URL {
            URL(string: "https://farm\(farm).staticflickr.com/\(server)/buddyicons/\(owner).jpg")!
        }
    
    static var sampleData: [Photo] {
        [
            Photo(id: "53844673585", owner: "154746989@N03", secret: "c4f54c3789", server: "65535", farm: 66, title: "51456 - East Lancashire Railway (Charter) - 8 July 2024-3033-Edit", ispublic: 1, isfriend: 0, isfamily: 0),
            Photo(id: "53844590004", owner: "154746989@N03", secret: "ba20587f33", server: "65535", farm: 66, title: "51456 - East Lancashire Railway (Charter) - 8 July 2024-3208-Edit-2", ispublic: 1, isfriend: 0, isfamily: 0)
        ]
    }
}
