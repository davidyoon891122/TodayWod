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
        let item: WorkOutDayModel
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
            ScrollView {
                VStack {
                    WorkOutDetailTitleView(item: store.item)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(store.item.workOuts) { workOut in
                            Text(workOut.type.title)
                                .font(Fonts.Pretendard.bold.swiftUIFont(size: 16))
                                .foregroundStyle(Colors.grey100.swiftUIColor)
                                .frame(height: 40)
                                .padding(.top, 10)
                            
                            LazyVStack(alignment: .leading, spacing: 10) {
                                ForEach(workOut.items) { item in
                                    WodView(model: item)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            }
            .background(Colors.blue10.swiftUIColor)
            .bind($store.isPresented, to: $isPresented)
            .onAppear {
                store.send(.onAppear)
            }
            .bottomSheet(isPresented: $isPresented) {
                BreakTimerView(store: Store(initialState: BreakTimeFeature.State()) {
                    BreakTimeFeature()
                })
            }
        }

    }
    
}



#Preview {
    WorkOutDetailView(store: Store(initialState: WorkOutDetailFeature.State(item: WorkOutDayModel.fake)) {
        WorkOutDetailFeature()
    })
}
