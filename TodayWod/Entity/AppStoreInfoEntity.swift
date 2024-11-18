//
//  AppStoreInfoEntity.swift
//  TodayWod
//
//  Created by Davidyoon on 11/15/24.
//

import Foundation

struct AppStoreResultInfoEntity: Codable {
    
    let resultCount: Int
    let results: [AppInfoEntity]
    
}

struct AppInfoEntity: Codable {
    
    let version: String
    
}
