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
    
    func saveOwnProgram(day: DayWorkOutModel)
    func saveOwnProgram(with: ProgramModel?)
    func loadOwnProgram() -> ProgramModel?
    
    func saveOfferedPrograms(data: [ProgramModel])
    func loadOfferedPrograms() -> [ProgramModel]
    
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
    
    func saveOwnProgram(day: DayWorkOutModel) {
        if var wodInfo = loadOwnProgram() {
            let weeklyWorkOuts: [DayWorkOutModel] = wodInfo.weeklyWorkOuts.map {
                $0.id == day.id ? day : $0
            }
            wodInfo.weeklyWorkOuts = weeklyWorkOuts
            
            self.saveOwnProgram(with: wodInfo)
        } else {
            self.userDefaults.set(nil, forKey: Constants.ownProgram)
        }
    }
    
    func saveOwnProgram(with data: ProgramModel?) {
        let encodedData = try? PropertyListEncoder().encode(data)
        self.userDefaults.set(encodedData, forKey: Constants.ownProgram)
    }
    
    func loadOwnProgram() -> ProgramModel? {
        guard let data = self.userDefaults.object(forKey: Constants.ownProgram) as? Data,
              let wodInfo = try? PropertyListDecoder().decode(ProgramModel.self, from: data) else { return nil }

        return wodInfo
    }
    
    // TODO: 최근 Day (3개 저장)
    // TODO: Date만 저장하는 애가 필요.
    
    func saveOfferedPrograms(data: [ProgramModel]) {
        let encodedData = try? PropertyListEncoder().encode(data)
        self.userDefaults.set(encodedData, forKey: Constants.offeredPrograms)
    }
    
    func loadOfferedPrograms() -> [ProgramModel] {
        guard let data = self.userDefaults.object(forKey: Constants.offeredPrograms) as? Data,
              let programs = try? PropertyListDecoder().decode([ProgramModel].self, from: data) else { return [] }

        return programs
    }
   
}

private extension UserDefaultsManager {

    enum Constants {
        static let userInfo: String = "UserInfo"
        static let onboardingUserInfo: String = "OnboardingUserInfo"
        static let offeredPrograms = "OfferedPrograms"
        static let ownProgram = "OwnProgram"
    }

}
