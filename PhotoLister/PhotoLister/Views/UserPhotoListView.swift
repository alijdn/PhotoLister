//
//  UserPhotoListView.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 14/07/2024.
//

import SwiftUI
import Kingfisher

struct UserPhotosView: View {
    @StateObject var viewModel: UserPhotoListViewModel
    let username: String
    
    init(username: String) {
        let viewModel = MainAssembler.shared.main.resolve(UserPhotoListViewModel.self)!
        _viewModel = StateObject(wrappedValue: viewModel)
        self.username = username
    }

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 3),
                    GridItem(.flexible(), spacing: 3),
                    GridItem(.flexible(), spacing: 3)
                ],
                spacing: 3
            ) {
                ForEach(viewModel.userPhotos) { photo in
                    TillView(imageUrl: photo.photoURL, size: 127, cornerRadius: 0)
                        .onAppear {
                            if shouldLoadNextPage(currentPhoto: photo) {
                                viewModel.getPhotosByUsername(owner: username)
                            }
                    }
                }
            }
        }
        .navigationTitle("User Photos")
        .onAppear {
            viewModel.getPhotosByUsername(owner: username)
        }
    }
    
    private func shouldLoadNextPage(currentPhoto: Photo) -> Bool {
           guard let lastPhoto = viewModel.userPhotos.last else { return false }
           return currentPhoto.id == lastPhoto.id
       }
}

struct TillView: View {
    let imageUrl: URL
    let size: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        KFImage(imageUrl)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(radius: 5)
    }
}
