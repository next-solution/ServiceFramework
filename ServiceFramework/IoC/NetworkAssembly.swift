//
//  NetworkAssembly.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 23/05/2021.
//

import Swinject

class NetworkAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(NetworkServiceProtocol.self, name: "NetworkServiceMock") { _ in
            NetworkServiceMock()
        }.inObjectScope(.container)
        container.register(NetworkServiceProtocol.self, name: "NetworkService") { _ in
            NetworkService()
        }.inObjectScope(.container)
    }
}
