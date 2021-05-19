//
//  GithubFetcher.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Alamofire

public class GithubFetcher : IFetcher {
    
    public static let `default` = GithubFetcher()
    
    public func fetchInfoAboutUsers(completion: @escaping (Result<[IUser], UserError>) -> Void) {
        networkService.execute(UsersAPIs.getUsers(.gitHub), model: [GithubUser].self) { result in
            switch result {
            case .success(let users):
                return completion(.success(users))
            case .failure(let error):
                let errorDescription = error.errorDescription ?? "Unknown error"
                return completion(.failure(UserError(description: errorDescription)))
            }
        }
    }
}
