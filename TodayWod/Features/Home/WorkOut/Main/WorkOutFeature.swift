//
//  WorkOutFeature.swift
//  TodayWod
//
//  Created by 오지연 on 9/18/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct WorkOutFeature {
    
    @ObservableState
    struct State: Equatable {
        let items: [WorkOutDayModel] = WorkOutDayModel.fakes
        var path = StackState<WorkOutDetailFeature.State>()
    }

    enum Action {
        case didTapDayView(item: WorkOutDayModel)
        case path(StackAction<WorkOutDetailFeature.State, WorkOutDetailFeature.Action>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .didTapDayView(item):
                state.path.append(WorkOutDetailFeature.State(item: item))
                return .none
            case .path(_):
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            WorkOutDetailFeature()
        }
    }
    
}

import SwiftUI

struct WorkOutView: View {
    
    @Perception.Bindable var store: StoreOf<WorkOutFeature>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                VStack(alignment: .leading) {
                    Text(Constants.weekWorkOutTitle)
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 20))
                        .foregroundStyle(Colors.grey100.swiftUIColor)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 13)
                    
                    ForEach(Array(store.items.enumerated()), id: \.element.id) { index, item in
                        WorkOutDayView(index: index, item: item)
                            .onTapGesture {
                                store.send(.didTapDayView(item: item))
                            }
                    }
                    
                    Spacer()
                }
            } destination: { store in
                WorkOutDetailView(store: store)
            }
        }
    }
    
}

private extension WorkOutView {
    
    enum Constants {
        static let weekWorkOutTitle: String = "한주 간 운동"
    }
    
}

