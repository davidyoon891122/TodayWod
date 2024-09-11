//
//  TodayWod.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/8/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct TodayWod {
    enum State: Equatable {
        case splash(SplashFeature.State)
        case app(AppFeature.State)
        case login(SocialLoginFeature.State)
    }

    enum Action {
        case splash(SplashFeature.Action)
        case app(AppFeature.Action)
        case login(SocialLoginFeature.Action)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .splash(.finishSplash):
                let userDefaulsManager = UserDefaultsManager()

                if let loginInfo = userDefaulsManager.loadUserInfo() {
                    state = .app(AppFeature.State())
                } else {
                    state = .login(SocialLoginFeature.State())
                }

                return .none
            case .splash, .app, .login:
                return .none
            }
        }
        .ifCaseLet(\.splash, action: \.splash) {
            SplashFeature()
        }
        .ifCaseLet(\.app, action: \.app) {
            AppFeature()
        }
        .ifCaseLet(\.login, action: \.login) {
            SocialLoginFeature()
        }
    }
}

import SwiftUI

struct RootView: View {

    let store: StoreOf<TodayWod>

    var body: some View {
        SwitchStore(self.store) { initialState in
            switch initialState {
            case .splash:
                CaseLet(/TodayWod.State.splash, action: TodayWod.Action.splash) { splashStore in
                    SplashView(store: splashStore)
                }
            case .app:
                CaseLet(/TodayWod.State.app, action: TodayWod.Action.app) { appStore in
                    ContentView(store: appStore)
                }
            case .login:
                CaseLet(/TodayWod.State.login, action: TodayWod.Action.login) { loginStore in
                    SocialLoginView(store: loginStore)
                }
            }
        }
    }
}
