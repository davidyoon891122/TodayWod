//
//  ContentView.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/7/24.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {

    let store: StoreOf<AppFeature>

    var body: some View {
        WithPerceptionTracking {
            // TODO: - 테스트를 위한 버튼
            Button(action: {
                store.send(.resetOnboarding)
            }, label: {
                Text("Back to onBoarding")
            })
            TabView {
                HomeView(store: store.scope(state: \.homeTab, action: \.homeTab))
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Display")
                    }

                SettingsView(store: store.scope(state: \.settingsTab, action: \.settingsTab))
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
        }
    }
}

#Preview {
    ContentView(store: Store(initialState: AppFeature.State()) {
        AppFeature()
    })
}
