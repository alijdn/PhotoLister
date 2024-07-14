//
//  PhotoListViewModelAssembly.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 14/07/2024.
//

import Foundation
import Swinject

final class PhotoDetailViewModelAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(PhotoDetailViewModel.self) { resolver in
            PhotoDetailViewModel(networkManager: resolver.resolve(NetworkManager.self)!)
        }
    }
}
