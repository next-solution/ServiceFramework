//
//  DailyMotionUsers.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Foundation

struct DailyMotionUsers: Codable, Equatable {
    let list: [DailyMotionUser]
}

struct DailyMotionUser: Equatable, User {
    var username: String
    var avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case avatarUrl = "avatar_360_url"
    }
}
