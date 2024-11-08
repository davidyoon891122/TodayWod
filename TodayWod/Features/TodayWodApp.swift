//
//  TodayWodApp.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/7/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct TodayWodApp: App {

    static let store = Store(initialState: TodayWod.State.splash(SplashFeature.State())) {
        TodayWod()
    }

    var body: some Scene {
        WindowGroup {
            TodayWodView(store: TodayWodApp.store)
        }
    }
}
