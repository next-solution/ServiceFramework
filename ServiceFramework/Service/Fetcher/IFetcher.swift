//
//  IApiClient.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Foundation

protocol IFetcher {
    func fetchInfoAboutUsers(completion: @escaping (Result<[IUser], UserError>) -> Void)
    func fetchAvatar(url: URL, completion: @escaping (Result<Data, UserError>) -> Void)
}

extension IFetcher {
    var networkService: NetworkServiceProtocol {
        return NetworkService.default
    }
    
    func fetchAvatar(url: URL, completion: @escaping (Result<Data, UserError>) -> Void) {
        networkService.retrieveImage(UsersAPIs.downloadImages(url)) { result in
            switch result {
            case .success(let data):
                return completion(.success(data))
            case .failure(let error):
                let errorDescription = error.errorDescription ?? "Unknown error"
                return completion(.failure(UserError(description: errorDescription)))
            }
        }
    }
}
