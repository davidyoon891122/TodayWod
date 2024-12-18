//
//  AppStoreResultRequestModel.swift
//  TodayWod
//
//  Created by Davidyoon on 11/15/24.
//

import Foundation

struct AppStoreResultRequestModel: Codable, RequestBodyPresentable {
    
    let bundleId: String
    let country: String

    init(bundleId: String, country: String = "kr") {
        self.bundleId = bundleId
        self.country = country
    }

}
