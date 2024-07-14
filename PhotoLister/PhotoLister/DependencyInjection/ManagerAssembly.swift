//
//  ManagerAssembly.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 13/07/2024.
//

import Swinject

final class NetworkManagerAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(NetworkManager.self) { _ in
            NetworkManager()
        }
    }
}
