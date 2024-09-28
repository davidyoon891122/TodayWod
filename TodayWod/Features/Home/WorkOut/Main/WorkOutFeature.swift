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
        var items: [WorkOutDayModel] = []
        var path = StackState<WorkOutDetailFeature.State>()

        @Presents var celebrateState: CelebrateFeature.State?
    }

    enum Action {
        case onAppear
        case didTapDayView(index: Int, item: WorkOutDayModel)
        case path(StackAction<WorkOutDetailFeature.State, WorkOutDetailFeature.Action>)
        case celebrateAction(PresentationAction<CelebrateFeature.Action>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                let userDefaultsManager = UserDefaultsManager()
                state.items = userDefaultsManager.loadWorkOutOfWeek()
                
                let isCelebrate = state.items.allSatisfy { $0.completedInfo.isCompleted }
                if isCelebrate {
                    state.celebrateState = CelebrateFeature.State()
                }
                return .none
            case let .didTapDayView(index, item):
                state.path.append(WorkOutDetailFeature.State(index: index, item: item))
                return .none
            case .path(_):
                return .none
            case .celebrateAction:
                return .none
            }
        }
        .ifLet(\.$celebrateState, action: \.celebrateAction) {
            CelebrateFeature()
        }
        .forEach(\.path, action: \.path) {
            WorkOutDetailFeature()
        }
    }
    
}

import SwiftUI

struct WorkOutView: View {
    
    @Perception.Bindable var store: StoreOf<WorkOutFeature>
    @State private var dynamicHeight: CGFloat = .zero

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
                                store.send(.didTapDayView(index: index, item: item))
                            }
                    }
                    
                    Spacer()
                }
                .onAppear {
                    store.send(.onAppear)
                }
            } destination: { store in
                WorkOutDetailView(store: store)
            }
            .sheet(item: $store.scope(state: \.celebrateState, action: \.celebrateAction)) { store in
                CelebrateView(store: store)
                    .presentationDetents([.height(dynamicHeight + 20.0)]) // 20 정도 여분을 주지 않으면 텍스트 잘림 현상 발생 가능성 있음
                    .presentationDragIndicator(.visible)
                    .background {
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    dynamicHeight = proxy.size.height
                                }
                        }
                    }
            }
        }
    }
    
}

private extension WorkOutView {
    
    enum Constants {
        static let weekWorkOutTitle: String = "한주 간 운동"
    }
    
}

