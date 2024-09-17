//
//  OnboardingUserInfoModel.swift
//  TodayWod
//
//  Created by Davidyoon on 9/13/24.
//

import Foundation

struct OnboardingUserInfoModel: Codable, Equatable {
    
    var gender: GenderType?
    var nickName: String?
    var height: Int?
    var weight: Int?
    var level: LevelType?
    var method: MethodType?

    init(gender: GenderType? = nil,
         nickName: String? = nil,
         height: Int? = nil,
         weight: Int? = nil,
         level: LevelType? = nil,
         method: MethodType? = nil) {
        self.gender = gender
        self.nickName = nickName
        self.height = height
        self.weight = weight
        self.level = level
        self.method = method
    }
    
}
