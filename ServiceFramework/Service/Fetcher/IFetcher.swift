//
//  IApiClient.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Foundation

public protocol IFetcher {
    func fetchInfoAboutUsers(endpoint: Endpoint, completion: @escaping (Result<[IUser], UserError>) -> Void)
    func fetchAvatar(url: URL, completion: @escaping (Result<Data, UserError>) -> Void)
}

extension IFetcher {
    var networkService: NetworkServiceProtocol {
        return NetworkService.default
    }
}
