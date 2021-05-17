//
//  GithubUsers.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Foundation

struct GithubUser: IUser {
    var username: String
    var avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarUrl = "avatar_360_url"
    }
}
