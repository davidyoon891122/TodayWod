//
//  WorkOutDetailFeature.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct WorkOutDetailFeature {
    
    @ObservableState
    struct State: Equatable {
        @Presents var timerState: BreakTimeFeature.State?
        var isPresented: Bool = false
    }

    enum Action: BindableAction {
        case onAppear
        case breakTimerAction(PresentationAction<BreakTimeFeature.Action>)
        case binding(BindingAction<State>)
    }

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isPresented = true
                return .none
            case .breakTimerAction:
                return .none
            case .binding:
                return .none
            }
        }
        .ifLet(\.$timerState, action: \.breakTimerAction) {
            BreakTimeFeature()
        }
    }
    
}

struct WorkOutDetailView: View {
    
    @Perception.Bindable var store: StoreOf<WorkOutDetailFeature>

    @State private var isPresented: Bool = false

    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .onAppear {
                store.send(.onAppear)
            }
            .bind($store.state.isPresented, to: $isPresented)
            .bottomSheet(isPresented: $isPresented) {
                BreakTimerView(store: Store(initialState: BreakTimeFeature.State()) {
                    BreakTimeFeature()
                })
            }
        }

    }
}

#Preview {
    WorkOutDetailView(store: Store(initialState: WorkOutDetailFeature.State()) {
        WorkOutDetailFeature()
    })
}
