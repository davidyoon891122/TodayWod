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
    func saveOwnProgram(with data: ProgramModel?)
    func loadOwnProgram() -> ProgramModel?
    
    func saveRecentDayWorkOuts(with data: RecentDayWorkOutModel)
    func loadRecentDayWorkOuts() -> [RecentDayWorkOutModel]
    
    func saveCompletedWods(with data: CompletedWodModel)
    func loadCompletedWods() -> [CompletedWodModel]
    
    func saveOfferedPrograms(with data: [ProgramModel])
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
            let dayWorkOuts: [DayWorkOutModel] = wodInfo.dayWorkOuts.map {
                $0.id == day.id ? day : $0
            }
            wodInfo.dayWorkOuts = dayWorkOuts
            
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
    
    func saveRecentDayWorkOuts(with data: RecentDayWorkOutModel) {
        let encodedData = try? PropertyListEncoder().encode(data)
        self.userDefaults.set(encodedData, forKey: Constants.recentDayWorkOuts)
    }
    
    func loadRecentDayWorkOuts() -> [RecentDayWorkOutModel] {
        guard let data = self.userDefaults.object(forKey: Constants.recentDayWorkOuts) as? Data,
              let dayWorkOuts = try? PropertyListDecoder().decode([RecentDayWorkOutModel].self, from: data) else { return RecentDayWorkOutModel.fakes } // TODO: 저장 구현 필요. 현재는 초기에 Fake.

        return dayWorkOuts
    }
    
    func saveCompletedWods(with data: CompletedWodModel) {
        let encodedData = try? PropertyListEncoder().encode(data)
        self.userDefaults.set(encodedData, forKey: Constants.CompletedWods)
    }
    
    func loadCompletedWods() -> [CompletedWodModel] {
        guard let data = self.userDefaults.object(forKey: Constants.CompletedWods) as? Data,
              let wods = try? PropertyListDecoder().decode([CompletedWodModel].self, from: data) else { return [] }

        return wods
    }
    
    func saveOfferedPrograms(with data: [ProgramModel]) {
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
        static let ownProgram = "OwnProgram"
        static let recentDayWorkOuts = "RecentDayWorkOuts"
        static let CompletedWods = "CompletedWods"
        static let offeredPrograms = "OfferedPrograms"
    }

}
