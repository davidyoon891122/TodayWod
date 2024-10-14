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
        var hasWod: Bool = UserDefaultsManager().loadOwnProgram() != nil

        var workOutEmpty = WorkOutEmptyFeature.State()
        var workOut = WorkOutFeature.State()

        var workOutList = WorkOutListFeature.State()

    }

    enum Action {
        case setWodInfo
        case workOutEmpty(WorkOutEmptyFeature.Action)
        case workOut(WorkOutFeature.Action)
        case workOutList(WorkOutListFeature.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.workOutEmpty, action: \.workOutEmpty) {
            WorkOutEmptyFeature()
        }
        
        Scope(state: \.workOut, action: \.workOut) {
            WorkOutFeature()
        }

        Scope(state: \.workOutList, action: \.workOutList) {
            WorkOutListFeature()
        }

        Reduce { state, action in
            switch action {
            case .setWodInfo:
                let userDefaultManager = UserDefaultsManager()
                let wodPrograms = userDefaultManager.loadOfferedPrograms()
                
                userDefaultManager.saveOwnProgram(with: wodPrograms.first)
                state.hasWod.toggle()
    
                return .none
            case .workOutEmpty(.didTapStartButton):
                return .run(operation: { send in
                    await send(.setWodInfo)
                })
            case .workOut:
                return .none
            case .workOutList:
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
            if store.hasWod {
//                WorkOutView(
//                    store: store.scope(
//                        state: \.workOut,
//                        action: \.workOut
//                    )
//                )
                WorkOutListView(store: store.scope(state: \.workOutList, action: \.workOutList))
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
