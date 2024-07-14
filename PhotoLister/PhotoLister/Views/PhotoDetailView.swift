//
//  PhotoDetailView.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 14/07/2024.
//

//import SwiftUI
import Combine
import SwiftUI
import Kingfisher

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
                    Header(imageURL: userIconURL, username: photoDetails.owner.username)
                        .padding(5)
                    Cell(imageURL: photoURL)
                        .padding(5)
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            
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
                            Text("Photo description")
                                .font(.title3)
                                .foregroundStyle(.purple)
                            ScrollView {
                                Text(photoDetails.description._content)
                            }
                        }
                        Spacer()
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
