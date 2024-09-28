//
//  UserDefaultsManager.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/10/24.
//

import Foundation

protocol UserDefaultsManagerProtocol {

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
    
    func saveOnboardingUserInfo(data: OnboardingUserInfoModel) {
        let encodedData = try? PropertyListEncoder().encode(data)
        self.userDefaults.set(encodedData, forKey: Constants.onboardingUserInfo)
    }
    
    func loadOnboardingUserInfo() -> OnboardingUserInfoModel? {
        guard let data = self.userDefaults.object(forKey: Constants.onboardingUserInfo) as? Data,
              let userInfo = try? PropertyListDecoder().decode(OnboardingUserInfoModel.self, from: data) else { return nil }

        return userInfo
    }
    
    func saveWorkOutDay(index: Int, data: WorkOutDayModel) {
        var workOutOfWeek: [WorkOutDayModel] = loadWorkOutOfWeek()
        workOutOfWeek[index] = data
        
        let encodedData = try? PropertyListEncoder().encode(workOutOfWeek)
        self.userDefaults.set(encodedData, forKey: Constants.workOutOfWeek)
    }
    
    func loadWorkOutOfWeek() -> [WorkOutDayModel] {
        guard let data = self.userDefaults.object(forKey: Constants.workOutOfWeek) as? Data,
              let weekModel = try? PropertyListDecoder().decode([WorkOutDayModel].self, from: data) else { return WorkOutDayModel.fakes }

        return weekModel
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
        static let workOutOfWeek = "WorkOutOfWeek"
        static let alreadyLaunch: String = "alreadyLaunch"
    }

}
