//
//  IApiClient.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Foundation

protocol IApiClient {
    func fetchInfoAboutDailyMotionUsers(completion: @escaping (Result<DailyMotionUsers?, DailyMotionError>?) -> Void)
    //TODO
    func fetchInfoAboutGithubUsers()
}
