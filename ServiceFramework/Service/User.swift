//
//  User.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Foundation

public protocol User: Codable {
    var username: String { get }
    var avatarUrl: String { get }
}
