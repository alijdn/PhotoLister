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
                .onSubmit {
                    viewModel.searchPhotos()
                }
            //Picker for tags or username search
            Picker("Search Option", selection: $viewModel.searchOption) {
                Text("Tags").tag(SearchOption.tags)
                Text("Username").tag(SearchOption.username)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding([.leading, .trailing])
            
            //Displaying error if no users found
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            //Displaying tags in a horizontal scroll view if the user is not searching for username
            if viewModel.isSearchingUserName == false {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(Array(viewModel.tags), id: \.self) { tag in
                            TagButton(tag: tag) {
                                viewModel.tags.remove(tag)
                                if viewModel.tags.isEmpty {
                                    viewModel.photos.removeAll()
                                } else {
                                    viewModel.getTaggedPhoto(tags: viewModel.getTagString, page: "1")
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            //Scroll view for displaying photos
            ScrollView {
                LazyVStack(spacing: 40) {
                    ForEach(viewModel.photos) { photo in
                        VStack {
                            //Navigating to a different view displaying user photos
                            NavigationLink(destination: UserPhotosView(username: photo.owner)) {
                                Header(imageURL: photo.userIconURL, username: photo.owner)
                            }
                            //Navigating to a different view displaying details about a single photo
                            NavigationLink(destination: PhotoDetailView(photoId: photo.id, photoUrl: photo.photoURL,userIconURL:photo.userIconURL)) {
                                    Cell(imageURL: photo.photoURL)
                                }
                            }
                            .onAppear() {
                                if photo.id == viewModel.photos.last?.id {
                                    print("Reached the last photo")
                                    if viewModel.lastPage > viewModel.currentPage {
                                        viewModel.currentPage += 1
                                        viewModel.getTaggedPhoto(tags: viewModel.getTagString, page: String(viewModel.currentPage))
                                    }
                                }
                            }
                        }
                    }
                    .padding(5)
                }
        }
        .navigationTitle("Search view")
        .onAppear() {
            viewModel.tags.insert("Yorkshire")
            viewModel.getTaggedPhoto(tags: "Yorkshire", page: "1")
        }
    }
}

enum SearchOption {
    case tags, username
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

struct TagButton: View {
    let tag: String
    var action: () -> Void

    var body: some View {
        HStack {
            Button(action: action) {
                Text(tag)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
            
                Image(systemName: "xmark.circle")
                    .foregroundColor(.blue)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}

