//
//  PhotoListView.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 11/07/2024.
//
import SwiftUI
import Kingfisher

struct PhotoListView: View {
    @StateObject var viewModel: PhotoListViewModel
    
    init() {
        let viewModel = MainAssembler.shared.main.resolve(PhotoListViewModel.self)!
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            // Search Box
            TextField("Search photos...", text: $viewModel.searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding([.leading, .trailing])
            //Displaying usericon, username and photo
            ScrollView {
                LazyVStack(spacing: 40) {
                    ForEach(viewModel.photos) { photo in
                        VStack {
                            NavigationLink(destination: UserPhotosView(username: photo.owner)) {
                                Header(imageURL: photo.userIconURL, username: photo.owner)
                            }
                            NavigationLink(destination: PhotoDetailView(photoId: photo.id, photoUrl: photo.photoURL, userIconURL: photo.userIconURL)) {
                                Cell(imageURL: photo.photoURL)
                            }
                        }
                    }
                }
                .padding(5)
            }
        }
        .navigationTitle("Search view")
        .onAppear() {
            viewModel.getTaggedPhoto(tags: ["Yorkshire"])
        }
    }
}

struct Cell: View {
    let imageURL: URL
    
    var body: some View {
        KFImage(imageURL)
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .shadow(radius: 2)
    }
}

struct Header: View {
    let imageURL: URL
    let username: String
    
    var body: some View {
        HStack {
            KFImage(imageURL)
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 50))
            Text(username)
                .font(.callout)
                .fontWeight(.bold)
            Spacer()
        }
    }
}

