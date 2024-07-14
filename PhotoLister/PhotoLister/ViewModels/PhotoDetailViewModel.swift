//
//  PhotoDetailViewModel.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 14/07/2024.
//

import Foundation
import Combine

class PhotoDetailViewModel: ObservableObject {
    let networkManager: NetworkManager
    private var tasks = Set<AnyCancellable>()
    @Published var photoDetails: PhotoDetailsResponse.PhotoDetails?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getPhotoDetails(photoId: String) {
        let request = PhotoDetailsRequest(photoId: photoId)
        
        networkManager.request(request)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] (response: PhotoDetailsResponse) in
                print("Response: \(response)")
                self?.photoDetails = response.photo
            }.store(in: &tasks)
    }
}
