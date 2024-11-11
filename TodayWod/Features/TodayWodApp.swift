//
//  TodayWodApp.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/7/24.
//

import SwiftUI
import ComposableArchitecture
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct TodayWodApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    static let store = Store(initialState: TodayWod.State.splash(SplashFeature.State())) {
        TodayWod()
    }

    var body: some Scene {
        WindowGroup {
            TodayWodView(store: TodayWodApp.store)
        }
    }
}
