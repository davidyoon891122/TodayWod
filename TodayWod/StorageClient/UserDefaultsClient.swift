//
//  UserDefaultsAPIClient.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 11/9/24.
//

import Foundation
import ComposableArchitecture

struct UserDefaultsClient {
    var saveOnboardingUserInfo: @Sendable (_ onboadingModel: OnboardingUserInfoModel) -> Void
    var loadOnboardingUserInfo: @Sendable () -> OnboardingUserInfoModel?
    var checkUserInfoExists: @Sendable () -> Bool
}

extension UserDefaultsClient: DependencyKey {

    static var liveValue: UserDefaultsClient = .init(saveOnboardingUserInfo: { model in
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

    var userDefaultsClient: UserDefaultsClient {
        get { self[UserDefaultsClient.self] }
        set { self[UserDefaultsClient.self] = newValue }
    }

}
