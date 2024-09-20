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
    func saveOnboardingUserInfo(data: OnboardingUserInfoModel)
    func loadOnboardingUserInfo() -> OnboardingUserInfoModel?
    
    var hasUserInfo: Bool { get }
    
}

final class UserDefaultsManager {

    private let userDefaults: UserDefaults

    var hasUserInfo: Bool {
        return self.loadOnboardingUserInfo() != nil
    }

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
    
    func saveOnboardingUserInfo(data: OnboardingUserInfoModel) {
        let encodedData = try? PropertyListEncoder().encode(data)
        self.userDefaults.set(encodedData, forKey: Constants.onboardingUserInfo)
    }
    
    func loadOnboardingUserInfo() -> OnboardingUserInfoModel? {
        guard let data = self.userDefaults.object(forKey: Constants.onboardingUserInfo) as? Data,
              let userInfo = try? PropertyListDecoder().decode(OnboardingUserInfoModel.self, from: data) else { return nil }

        return userInfo
    }
    
    func saveIsAlreadyLaunch(data: Bool) {
        self.userDefaults.set(data, forKey: Constants.alreadyLaunch)
    }
    
    func loadIsAlreadyLaunch() -> Bool {
        self.userDefaults.bool(forKey: Constants.alreadyLaunch)
    }

}

private extension UserDefaultsManager {

    enum Constants {
        static let userInfo: String = "UserInfo"
        static let onboardingUserInfo: String = "OnboardingUserInfo"
        static let alreadyLaunch: String = "alreadyLaunch"
    }

}
