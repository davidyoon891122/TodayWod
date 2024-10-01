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
    
    func saveWodInfo(day: WorkOutDayModel)
    func saveWodInfo(data: WodInfo?)
    func loadWodInfo() -> WodInfo?
    
    func saveWodPrograms(data: [WodInfo])
    func loadWodPrograms() -> [WodInfo]
    
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
    
    func saveWodInfo(day: WorkOutDayModel) {
        if var wodInfo = loadWodInfo() {
            let workOutOfWeek: [WorkOutDayModel] = wodInfo.workOutDays.map {
                $0.id == day.id ? day : $0
            }
            wodInfo.workOutDays = workOutOfWeek
            
            self.saveWodInfo(data: wodInfo)
        } else {
            self.userDefaults.set(nil, forKey: Constants.wodInfo)
        }
    }
    
    func saveWodInfo(data: WodInfo?) {
        let encodedData = try? PropertyListEncoder().encode(data)
        self.userDefaults.set(encodedData, forKey: Constants.wodInfo)
    }
    
    func loadWodInfo() -> WodInfo? {
        guard let data = self.userDefaults.object(forKey: Constants.wodInfo) as? Data,
              let wodInfo = try? PropertyListDecoder().decode(WodInfo.self, from: data) else { return nil }

        return wodInfo
    }
    
    func saveWodPrograms(data: [WodInfo]) {
        let encodedData = try? PropertyListEncoder().encode(data)
        self.userDefaults.set(encodedData, forKey: Constants.wodPrograms)
    }
    
    func loadWodPrograms() -> [WodInfo] {
        guard let data = self.userDefaults.object(forKey: Constants.wodPrograms) as? Data,
              let programs = try? PropertyListDecoder().decode([WodInfo].self, from: data) else { return [] }

        return programs
    }
   
}

private extension UserDefaultsManager {

    enum Constants {
        static let userInfo: String = "UserInfo"
        static let onboardingUserInfo: String = "OnboardingUserInfo"
        static let wodPrograms = "WodPrograms"
        static let wodInfo = "WodInfo"
    }

}
