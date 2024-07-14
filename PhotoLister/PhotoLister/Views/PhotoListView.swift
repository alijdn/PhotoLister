//
//  PhotoListView.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 11/07/2024.
//
import SwiftUI

struct PhotoListView: View {
    @StateObject var viewModel: PhotoListViewModel
    
    init() {
        let viewModel = MainAssembler.shared.main.resolve(PhotoListViewModel.self)!
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // Search Box
                TextField("Search photos...", text: $viewModel.searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding([.leading, .trailing])
                
                // Scroll View with Images
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.photos) { photo in
                            VStack(alignment: .leading) {
                                
                                // Profile Picture and ID
                                HStack {
                                    NavigationLink(destination: UserPhotosView(username: photo.owner)) {
                                        HStack {
                                            AsyncImage(url: photo.userIconURL) { image in
                                                image.resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 50, height: 50)
                                                    .clipShape(Circle())
                                            } placeholder: {
                                                Circle()
                                                    .fill(Color.gray)
                                                    .frame(width: 50, height: 50)
                                            }
                                            
                                            VStack(alignment: .leading) {
                                                Text(photo.owner)
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }
                                            Spacer()
                                        }
                                    }
                                }
                                .padding(.bottom, 5)
                                
                                // Profile Photo
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
            }
            .navigationTitle("Photo search")
            .onAppear() {
                viewModel.getTaggedPhoto()
            }
        }
    }
}
