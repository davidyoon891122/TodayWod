//
//  UserDefaultsManager.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/10/24.
//

import Foundation

protocol UserDefaultsManagerProtocol {

    func saveUserInfo(data: UserInfoModel)
    func loadUserInfo() -> UserInfoModel?

}

final class UserDefaultsManager {

    private let userDefaults: UserDefaults


    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

}

extension UserDefaultsManager: UserDefaultsManagerProtocol {

    func saveUserInfo(data: UserInfoModel) {
        let encodedData = try? PropertyListEncoder().encode(data)
        self.userDefaults.set(encodedData, forKey: Constants.userInfo)
    }
    
    func loadUserInfo() -> UserInfoModel? {
        guard let data = self.userDefaults.object(forKey: Constants.userInfo) as? Data,
              let userInfo = try? PropertyListDecoder().decode(UserInfoModel.self, from: data) else { return nil }

        return userInfo
    }
    

}

private extension UserDefaultsManager {

    enum Constants {
        static let userInfo: String = "UserInfo"
    }

}
