//
//  HomeFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/8/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct HomeFeature {
    
    @ObservableState
    struct State: Equatable {
        var isAlreadyLaunch = UserDefaultsManager().loadIsAlreadyLaunch()
        var workOutEmpty = WorkOutEmptyFeature.State()
        var workOut = WorkOutFeature.State()
    }

    enum Action {
        case toggleIsAlreadyLaunch(Bool)
        case workOutEmpty(WorkOutEmptyFeature.Action)
        case workOut(WorkOutFeature.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.workOutEmpty, action: \.workOutEmpty) {
            WorkOutEmptyFeature()
        }
        
        Scope(state: \.workOut, action: \.workOut) {
            WorkOutFeature()
        }
        
        Reduce { state, action in
            switch action {
            case let .toggleIsAlreadyLaunch(isAlreadyLaunch):
                state.isAlreadyLaunch = isAlreadyLaunch
                UserDefaultsManager().saveIsAlreadyLaunch(data: isAlreadyLaunch)
                return .none
            case .workOutEmpty(.didTapStartButton):
                return .run(operation: { send in
                    await send(.toggleIsAlreadyLaunch(true))
                })
            case .workOut:
                return .none
            }
        }
    }
    
}

import SwiftUI

struct HomeView: View {

    let store: StoreOf<HomeFeature>

    var body: some View {
        WithPerceptionTracking {
            if store.isAlreadyLaunch {
                WorkOutView(
                    store: store.scope(
                        state: \.workOut,
                        action: \.workOut
                    )
                )
            } else {
                WorkOutEmptyView(
                    store: store.scope(
                        state: \.workOutEmpty,
                        action: \.workOutEmpty
                    )
                )
            }
        }
    }
    
}

#Preview {
    HomeView(store: Store(initialState: HomeFeature.State()) {
        HomeFeature()
    })
}
