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
    }

    enum Action {
        case splash(SplashFeature.Action)
        case app(AppFeature.Action)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .splash(.finishSplash):
                state = .app(AppFeature.State())
                return .none
            case .splash, .app:
                return .none
            }
        }
        .ifCaseLet(\.splash, action: \.splash) {
            SplashFeature()
        }
        .ifCaseLet(\.app, action: \.app) {
            AppFeature()
        }
    }
}

import SwiftUI

struct RootView: View {

    let store: StoreOf<TodayWod>

    var body: some View {
        SwitchStore(self.store) { initialState in
            CaseLet(/TodayWod.State.splash, action: TodayWod.Action.splash) { splashStore in
                SplashView(store: splashStore)
            }
            CaseLet(/TodayWod.State.app, action: TodayWod.Action.app) { appStore in
                ContentView(store: appStore)
            }
        }
    }
}
