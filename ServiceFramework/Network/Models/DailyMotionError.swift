//
//  DailyMotionError.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Foundation

struct DailyMotionError: Codable, Error {
    let error: DailyMotionErrorFields?
}

struct DailyMotionErrorFields: Codable, Error {
    let code: Int?
    let message: String?
    let type: String?
}
