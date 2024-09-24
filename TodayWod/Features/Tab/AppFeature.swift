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
        var settingsTab = MyActivityFeature.State()
        var selectedItem: TabMenuItem = .home
    }

    enum Action: BindableAction {
        case homeTab(HomeFeature.Action)
        case settingsTab(MyActivityFeature.Action)
        case resetOnboarding
        case binding(BindingAction<State>)

    }

    var body: some ReducerOf<Self> {
        Scope(state: \.homeTab, action: \.homeTab) {
            HomeFeature()
        }

        Scope(state: \.settingsTab, action: \.settingsTab) {
            MyActivityFeature()
        }

        BindingReducer()
        Reduce { state, action in
            switch action {
            case .resetOnboarding:
                return .none
            case .binding:
                return .none
            case .homeTab, .settingsTab:
                return .none
            }
        }
    }

}

import SwiftUI


struct AppTabView: View {

    @Perception.Bindable var store: StoreOf<AppFeature>
    @State private var selectedItem: TabMenuItem = .home

    var body: some View {
        WithPerceptionTracking {
            // TODO: - 테스트를 위한 버튼
            Button(action: {
                store.send(.resetOnboarding)
            }, label: {
                Text("Back to onBoarding")
            })
            VStack(spacing: 0) {
                switch store.state.selectedItem {
                case .home:
                    HomeView(store: store.scope(state: \.homeTab, action: \.homeTab))
                case .settings:
                    MyActivityView(store: store.scope(state: \.settingsTab, action: \.settingsTab))
                }
                CustomTabView(selectedItem: $selectedItem)
                    .padding(.bottom, 20)
                    .bind($store.state.selectedItem, to: $selectedItem)
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
