//
//  PhotoListVMAssembly.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 14/07/2024.
//

import Swinject

final class PhotoListViewModelAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(PhotoListViewModel.self) { resolver in
            PhotoListViewModel(networkManager: resolver.resolve(NetworkManager.self)!)
        }
    }
}
