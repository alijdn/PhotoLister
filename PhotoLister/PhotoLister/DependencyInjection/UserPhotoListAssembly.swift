//
//  UserPhotoListAssembly.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 14/07/2024.
//

import Foundation
import Swinject

final class UserPhotoListViewModelAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(UserPhotoListViewModel.self) { resolver in
            UserPhotoListViewModel(networkManager: resolver.resolve(NetworkManager.self)!)
        }
    }
}
