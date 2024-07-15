//
//  UserPhotoListViewModel.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 14/07/2024.
//

import Foundation
import Combine

class UserPhotoListViewModel: ObservableObject {
    private let networkManager: NetworkManager
    private var subscriptions = Set<AnyCancellable>()
    var currentPage = 1
    var lastPage = 0
    
    @Published var userPhotos: [Photo] = []
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    func getPhotosByUsername(owner: String, page: String) {
        let request = PhotosByUsernameRequest(username: owner, page: page)
        
        networkManager.request(request)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] (response: FlickrResponse) in
                if self?.lastPage == 0 {
                    self?.lastPage = response.photos.pages
                }
                self?.userPhotos.append(contentsOf: response.photos.photo)
            }.store(in: &subscriptions)
    }
}
