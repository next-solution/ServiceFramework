//
//  UserInfoService.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 19/05/2021.
//

import Foundation

public class UserInfoService {
    public static let `default` = UserInfoService()
    
    private let dailyMotionFetcher: IFetcher = DailyMotionFetcher()
    private let gitHubFetcher: IFetcher = GithubFetcher()
    
    public func fetchInfoAboutUsers(completion: @escaping ([UserData]) -> Void) {
        self.dailyMotionFetcher.fetchInfoAboutUsers() { result in
            switch result {
            case .success(let users):
                completion(users.compactMap { user in
                    UserData(serviceType: .dailyMotion, name: user.username , avatar: nil)
                })
            case .failure(_):
                completion([])
            }
            
            self.gitHubFetcher.fetchInfoAboutUsers() { result in
                switch result {
                case .success(let users):
                    completion(users.compactMap { user in
                        UserData(serviceType: .gitHub, name: user.username , avatar: nil)
                    })
                case .failure(_):
                    completion([])
                }
            }
        }
    }
}
