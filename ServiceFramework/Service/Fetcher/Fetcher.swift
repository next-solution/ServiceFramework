//
//  Fetcher.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Alamofire

public class Fetcher: IFetcher {
    
    public static let `default`: Fetcher = {
        let fetcher = Fetcher()
        return fetcher
    }()
    
    public func fetchInfoAboutUsers(endpoint: Endpoint, completion: @escaping (Result<[IUser], UserError>) -> Void) {
        switch endpoint {
        case .dailyMotion:
            fetchUsersFromDailyMotion() { result in
                completion(result)
            }
        case .gitHub:
            fetchUsersFromGithub() { result in
                completion(result)
            }
        }
    }
    
    public func fetchAvatar(url: URL, completion: @escaping (Result<Data, UserError>) -> Void) {
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
    
    private func fetchUsersFromDailyMotion(completion: @escaping (Result<[IUser], UserError>) -> Void) {
        networkService.execute(UsersAPIs.getUsers(.dailyMotion), model: DailyMotionUsers.self) { result in
            switch result {
            case .success(let users):
                return completion(.success(users.list))
            case .failure(let error):
                let errorDescription = error.errorDescription ?? "Unknown error"
                return completion(.failure(UserError(description: errorDescription)))
            }
        }
    }
    
    private func fetchUsersFromGithub(completion: @escaping (Result<[IUser], UserError>) -> Void) {
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
