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
    @ObservableState
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

struct TodayWodView: View {

    let store: StoreOf<TodayWod>

    var body: some View {
        switch store.state {
        case .splash:
            if let store = store.scope(state: \.splash, action: \.splash) {
                SplashView(store: store)
            }
        case .app:
            if let store = store.scope(state: \.app, action: \.app) {
                ContentView(store: store)
            }
        case .login:
            if let store = store.scope(state: \.login, action: \.login) {
                SocialLoginView(store: store)
            }
        }
    }
}
