//
//  IApiClient.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Foundation

public protocol FetcherProtocol {
    func fetchInfoAboutUsers(completion: @escaping ([(endpoint: Endpoint, users: Result<[User], UserError>)]) -> Void)
    func fetchAvatar(url: URL, completion: @escaping (Result<Data, UserError>) -> Void)
}
