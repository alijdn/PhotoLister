//
//  PhotoListViewModel.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 11/07/2024.
//

import Foundation
import Combine

class PhotoListViewModel: ObservableObject {
    private let networkManager: NetworkManager
    private var subscriptions = Set<AnyCancellable>()
    @Published var errorMessage: String?
    
    @Published var photos: [Photo] = []
    @Published var tags = Set<String>()
    
    @Published var searchOption: SearchOption = .tags
    @Published var isSearchingUserName: Bool = false
    var searchText = ""
    var currentPage = 1
    var lastPage = 0
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getTaggedPhoto(tags: String, page: String) {
        let request = PhotosByTagsRequest(tags: tags, page: page)
        
        networkManager.request(request)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                    self.errorMessage = "Failed to load photos with tags '\(tags)'. Please try again."
                }
            } receiveValue: { [weak self] (response: FlickrResponse) in
                if self?.lastPage == 0 {
                    self?.lastPage = response.photos.pages
                }
                if self?.currentPage == 1 {
                    self?.photos = response.photos.photo
                } else {
                    self?.photos += response.photos.photo
                }
            }.store(in: &subscriptions)
    }
    
    func getPhotosByUsername(owner: String, page: String) {
        let request = PhotosByUsernameRequest(username: owner, page: page)
        networkManager.request(request)
            .sink { completion in
                switch completion {
                case .finished:
                    self.errorMessage = nil
                case .failure(let error):
                    print("Error: \(error)")
                    self.errorMessage = "Unable to load photos for user '\(owner)'. Please check the username and try again."
                    self.photos.removeAll()
                }
            } receiveValue: { [weak self] (response: FlickrResponse) in
                if self?.lastPage == 0 {
                    self?.lastPage = response.photos.pages
                }
                if self?.currentPage == 1 {
                    self?.photos = response.photos.photo
                } else {
                    self?.photos += response.photos.photo
                }
                self?.photos = response.photos.photo
            }.store(in: &subscriptions)
    }
    
    func searchPhotos() {
        switch searchOption {
        case .tags:
            isSearchingUserName = false
            lastPage = 0
            errorMessage = nil
            getTaggedPhoto(tags: getTagString, page: "1")
        case .username:
            tags.removeAll()
            isSearchingUserName = true
            lastPage = 0
            getPhotosByUsername(owner: searchText.filter { !$0.isWhitespace }, page: "1")
        }
    }
    
    var getTagString: String {
        let cleanedTags = searchText.filter { !$0.isWhitespace }
        tags.insert(cleanedTags)
        let tagString = tags.map { $0 }.joined(separator: ",")
        return tagString
    }
}
