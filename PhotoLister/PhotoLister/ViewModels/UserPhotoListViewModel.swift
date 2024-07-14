//
//  UserPhotoListViewModel.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 14/07/2024.
//

import Foundation
import Combine

class UserPhotoListViewModel: ObservableObject {
    let networkManager: NetworkManager
    private var tasks = Set<AnyCancellable>()
    
    @Published var userPhotos: [Photo] = []
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    func getPhotosByUsername(owner: String) {
        let request = PhotosByUsernameRequest(username: owner)
        
        networkManager.request(request)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] (response: FlickrResponse) in
                self?.userPhotos = response.photos.photo
            }.store(in: &tasks)
    }
}
