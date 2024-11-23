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
        case onBoarding(GenderSelectFeature.State)
    }

    enum Action {
        case splash(SplashFeature.Action)
        case app(AppFeature.Action)
        case onBoarding(GenderSelectFeature.Action)
    }

    @Dependency(\.userDefaultsClient) var userDefaultsClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .splash(.finishSplash):

                if userDefaultsClient.checkUserInfoExists() {
                    state = .app(AppFeature.State())
                } else {
                    state = .onBoarding(GenderSelectFeature.State())
                }

                return .none
            case .onBoarding(.finishOnboarding):
                state = .app(AppFeature.State())
                return .none
            case .app(.resetOnboarding):
                state = .onBoarding(GenderSelectFeature.State())
                return .none
            case .splash, .app, .onBoarding:
                return .none
            }
        }
        .ifCaseLet(\.splash, action: \.splash) {
            SplashFeature()
        }
        .ifCaseLet(\.app, action: \.app) {
            AppFeature()
        }
        .ifCaseLet(\.onBoarding, action: \.onBoarding) {
            GenderSelectFeature()
        }
    }
}

import SwiftUI

struct TodayWodView: View {

    let store: StoreOf<TodayWod>

    var body: some View {
        WithPerceptionTracking {
            switch store.state {
            case .splash:
                if let store = store.scope(state: \.splash, action: \.splash) {
                    SplashView(store: store)
                }
            case .app:
                if let store = store.scope(state: \.app, action: \.app) {
                    AppTabView(store: store)
                }
            case .onBoarding:
                if let store = store.scope(state: \.onBoarding, action: \.onBoarding) {
                    GenderSelectView(store: store)
                }
            }
        }
    }
}
