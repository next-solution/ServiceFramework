//
//  UserData.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Foundation

public struct UserData {
    public let name: String
    public let avatar: Data
    public let endpoint: Endpoint
    
    public init(name: String, avatar: Data) {
        self.name = name
        self.avatar = avatar
    }
}
