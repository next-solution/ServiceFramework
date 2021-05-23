//
//  Assembler.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 23/05/2021.
//

import Swinject

extension Assembler {
    public static let `default`: Assembler = {
        let container = Container()
        let assembler = Assembler([
            NetworkAssembly(),
            FetcherAssembly()
        ], container: container)
        return assembler
    }()
}
