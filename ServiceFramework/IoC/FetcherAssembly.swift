//
//  FetcherAssembly.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 23/05/2021.
//

import Swinject

class FetcherAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(FetcherProtocol.self, name: "Fetcher") { resolver in
            let networkService = resolver.resolve(NetworkServiceProtocol.self, name: "NetworkService")
            return Fetcher(networkService: networkService!)
        }
        
        container.register(FetcherProtocol.self, name: "FetcherMock") { resolver in
            let networkService = resolver.resolve(NetworkServiceProtocol.self, name: "NetworkServiceMock")
            return Fetcher(networkService: networkService!)
        }
    }
}
