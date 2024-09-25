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
    var method: ProgramMethodType?

    init(gender: GenderType? = nil,
         nickName: String? = nil,
         height: Int? = nil,
         weight: Int? = nil,
         level: LevelType? = nil,
         method: ProgramMethodType? = nil) {
        self.gender = gender
        self.nickName = nickName
        self.height = height
        self.weight = weight
        self.level = level
        self.method = method
    }
    
}

extension OnboardingUserInfoModel {
    
    static let preview: Self = .init(gender: .man, nickName: "The King", height: 192, weight: 101, level: .advanced, method: .machine)

}

extension OnboardingUserInfoModel {
    
    func convertToSubArray() -> [UserInfoSubItemModel] {
        var subItems: [UserInfoSubItemModel] = []
                
        if let gender = gender {
            subItems.append(UserInfoSubItemModel(title: "성별", value: "\(gender)"))
        }
        
        if let height = height {
            subItems.append(UserInfoSubItemModel(title: "키", value: "\(height) cm"))
        }
        
        if let weight = weight {
            subItems.append(UserInfoSubItemModel(title: "몸무게", value: "\(weight) kg"))
        }
        
        if let level = level {
            subItems.append(UserInfoSubItemModel(title: "운동 수준", value: "\(level)"))
        }
        
        if let method = method {
            subItems.append(UserInfoSubItemModel(title: "운동 방식", value: "\(method)"))
        }
        
        return subItems
    }
    
}

struct UserInfoSubItemModel: Equatable, Hashable {
    
    var title: String
    var value: String
    
}
