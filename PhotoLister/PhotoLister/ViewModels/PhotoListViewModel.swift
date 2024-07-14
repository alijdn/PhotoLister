//
//  PhotoListViewModel.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 11/07/2024.
//

import Foundation
import Combine

class PhotoListViewModel: ObservableObject {
    let networkManager: NetworkManager
    private var tasks = Set<AnyCancellable>()
    
    @Published var photos: [Photo] = []
    var searchText = "";
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getTaggedPhoto() {
        let request = PhotosByTagsRequest(tags: "Yorkshire")
        
        networkManager.request(request)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] (response: FlickrResponse) in
                self?.photos = response.photos.photo
            }.store(in: &tasks)
    }
}


