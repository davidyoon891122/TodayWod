//
//  UserDefaultsAPIClient.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 11/9/24.
//

import Foundation
import ComposableArchitecture

struct UserDefaultsAPIClient {
    var saveOnboardingUserInfo: @Sendable (_ onboadingModel: OnboardingUserInfoModel) -> Void
    var loadOnboardingUserInfo: @Sendable () -> OnboardingUserInfoModel?
    var checkUserInfoExists: @Sendable () -> Bool
}

extension UserDefaultsAPIClient: DependencyKey {

    static var liveValue: UserDefaultsAPIClient = .init(saveOnboardingUserInfo: { model in
        let userDefaultsManager = UserDefaultsManager()
        userDefaultsManager.saveOnboardingUserInfo(data: model)
    }, loadOnboardingUserInfo: {
        let userDefaultsManager = UserDefaultsManager()
        return userDefaultsManager.loadOnboardingUserInfo()
    }, checkUserInfoExists: {
        let userDefaultsManager = UserDefaultsManager()
        return userDefaultsManager.hasUserInfo
    })

}

extension DependencyValues {

    var userDefaultsAPIClient: UserDefaultsAPIClient {
        get { self[UserDefaultsAPIClient.self] }
        set { self[UserDefaultsAPIClient.self] = newValue }
    }

}
