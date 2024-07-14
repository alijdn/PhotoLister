//
//  MainAssembler.swift
//  PhotoLister
//
//  Created by ali Jamaldin on 13/07/2024.
//

import Swinject

final class MainAssembler {
    public static let shared = MainAssembler()
    
    let main: Container
    private let assembler: Assembler
    
    private init() {
        main = Container()
        assembler = Assembler(
            [NetworkManagerAssembly(), PhotoListViewModelAssembly(), UserPhotoListViewModelAssembly()],
            container: main)
    }
}
