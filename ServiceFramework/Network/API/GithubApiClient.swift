//
//  GithubApiClient.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Alamofire

struct GithubApiClient : IApiClient {
    
    func fetchInfoAboutUsers(completion: @escaping (Result<[IUser]?, UserError>) -> Void) {
        sendRequest(url: Link.gitHubUrl, type: [GithubUser].self) { result in
            switch result {
            case .success(let users):
                return completion(.success(users))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
}
