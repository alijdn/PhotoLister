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
    private var currentPage = 1
    private var isFetching = false
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    func getPhotosByUsername(owner: String) {
        let request = PhotosByUsernameRequest(username: owner, page: currentPage)
        
        guard !isFetching else { return }
        isFetching = true
        
        networkManager.request(request)
            .sink { completion in
                self.isFetching = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] (response: FlickrResponse) in
                self?.userPhotos.append(contentsOf: response.photos.photo)
                self?.currentPage += 1
            }.store(in: &tasks)
    }
}
