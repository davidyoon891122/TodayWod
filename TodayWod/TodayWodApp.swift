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

    static let store = Store(initialState: SplashFeature.State()) {
        SplashFeature()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(store: TodayWodApp.store)
        }
    }
}
