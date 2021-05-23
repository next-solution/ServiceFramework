//
//  Fetcher.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Alamofire

public class Fetcher: FetcherProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    public func fetchInfoAboutUsers(completion: @escaping ([(endpoint: Endpoint, users: Result<[User], UserError>)]) -> Void) {
        var dailyMotionResult: Result<[User], UserError> = .success([])
        var gitHubResult: Result<[User], UserError> = .success([])
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        fetchUsersFromDailyMotion() { result in
            switch result {
            case .success(let users):
                dailyMotionResult = .success(users)
            case .failure(let error):
                dailyMotionResult = .failure(error)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchUsersFromGithub() { result in
            switch result {
            case .success(let users):
                gitHubResult = .success(users)
            case .failure(let error):
                gitHubResult = .failure(error)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion([(.dailyMotion, dailyMotionResult), (.gitHub, gitHubResult)])
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
    
    private func fetchUsersFromDailyMotion(completion: @escaping (Result<[User], UserError>) -> Void) {
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
    
    private func fetchUsersFromGithub(completion: @escaping (Result<[User], UserError>) -> Void) {
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
