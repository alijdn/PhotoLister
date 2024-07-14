//
//  PhotoDetailView.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 14/07/2024.
//

//import SwiftUI
import Combine
import SwiftUI



struct PhotoDetailView: View {
    @StateObject var viewModel: PhotoDetailViewModel
    let photoId: String
    let photoURL: URL
    let userIconURL: URL
    
    init(photoId: String, photoUrl: URL, userIconURL: URL) {
        let viewModel = MainAssembler.shared.main.resolve(PhotoDetailViewModel.self)!
        _viewModel = StateObject(wrappedValue: viewModel)
        self.photoId = photoId
        self.photoURL = photoUrl
        self.userIconURL = userIconURL
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if let photoDetails = viewModel.photoDetails {
                HStack {
                    AsyncImage(url: userIconURL) { image in
                        image.image?.resizable().frame(width: 50, height: 50, alignment: .center)
                            .cornerRadius(50)
                    }
                    Text(photoDetails.owner.username)
                        .font(.callout)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 8)
                
                AsyncImage(url: photoURL) { image in
                    image.image?.resizable().scaledToFit()
                }

                VStack(alignment: .leading) {
                    Text("Photo title")
                        .font(.title3)
                        .foregroundStyle(.purple)
                    Text(photoDetails.title._content)
                    Text("Date taken")
                        .font(.title3)
                        .foregroundStyle(.purple)
                    Text(photoDetails.dates.taken)
                    Text("Photo description")
                        .font(.title3)
                        .foregroundStyle(.purple)
                    ScrollView {
                        Text(photoDetails.description._content)
                    }
                }
                .padding()
                Spacer()
            }
        }
        .onAppear {
            viewModel.getPhotoDetails(photoId: photoId)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
