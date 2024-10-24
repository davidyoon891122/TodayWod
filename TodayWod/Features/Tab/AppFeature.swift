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

    @ObservableState
    struct State: Equatable, Sendable {
        var homeTab = HomeFeature.State()
        var settingsTab = SettingFeature.State()

        @Shared(.inMemory("TabType")) var tabType: TabMenuType = .home
        @Shared(.inMemory("HideTabBar")) var hideTabBar: Bool = false
    }

    enum Action: BindableAction {
        case homeTab(HomeFeature.Action)
        case settingsTab(SettingFeature.Action)
        case resetOnboarding
        case binding(BindingAction<State>)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.homeTab, action: \.homeTab) {
            HomeFeature()
        }

        Scope(state: \.settingsTab, action: \.settingsTab) {
            SettingFeature()
        }

        BindingReducer()
        Reduce { state, action in
            switch action {
            case .resetOnboarding:
                return .none
            case .homeTab, .settingsTab:
                return .none
            case .binding:
                return .none
            }
        }
    }

}

import SwiftUI


struct AppTabView: View {

    @Perception.Bindable var store: StoreOf<AppFeature>

    var body: some View {
        WithPerceptionTracking {
            // TODO: - 테스트를 위한 버튼
            Button(action: {
                store.send(.resetOnboarding)
            }, label: {
                Text("Back to onBoarding")
            })
            VStack(spacing: 0) {
                switch store.tabType {
                case .home:
                    HomeView(store: store.scope(state: \.homeTab, action: \.homeTab))
                case .settings:
                    SettingView(store: store.scope(state: \.settingsTab, action: \.settingsTab))
                }
                if !store.hideTabBar {
                    CustomTabView(tabType: $store.tabType)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    AppTabView(store: Store(initialState: AppFeature.State()) {
        AppFeature()
    })
}
