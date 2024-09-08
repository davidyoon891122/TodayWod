//
//  AppFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/8/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AppFeature {

    struct State: Equatable {
        var homeTab = HomeFeature.State()
        var settingsTab = SettingsFeature.State()
    }

    enum Action {
        case homeTab(HomeFeature.Action)
        case settingsTab(SettingsFeature.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.homeTab, action: \.homeTab) {
            HomeFeature()
        }

        Scope(state: \.settingsTab, action: \.settingsTab) {
            SettingsFeature()
        }

        Reduce { state, action in
            return .none
        }
    }

}

