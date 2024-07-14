//
//  UserPhotoListView.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 14/07/2024.
//

import SwiftUI

struct UserPhotosView: View {
    @StateObject var viewModel: UserPhotoListViewModel
    let username: String
    
    init(username: String) {
        let viewModel = MainAssembler.shared.main.resolve(UserPhotoListViewModel.self)!
        _viewModel = StateObject(wrappedValue: viewModel)
        self.username = username
    }
    
    var gridItem: [GridItem] = [GridItem(.flexible(), spacing: 1),
                                GridItem(.flexible(), spacing: 1),
                                GridItem(.flexible(), spacing: 1)]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.userPhotos) { photo in
                    VStack(alignment: .leading) {
                        AsyncImage(url: photo.photoURL) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .clipped()
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(height: 200)
                                .overlay(
                                    Text("Image Placeholder")
                                        .foregroundColor(.white)
                                )
                        }
                        Text(photo.title)
                            .padding(.top, 5)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("User Photos")
        .onAppear {
            viewModel.getPhotosByUsername(owner: username)
        }
    }
}


struct UserPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        UserPhotosView(username: "example_user")
    }
}
