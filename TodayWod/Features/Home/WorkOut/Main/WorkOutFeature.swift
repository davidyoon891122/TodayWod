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
    
    @Reducer(state: .equatable)
    enum Path {
        case detail(WorkOutDetailFeature)
        case completed(WorkOutCompletedFeature)
    }
    
    @ObservableState
    struct State: Equatable {
        var ownProgram: ProgramModel? = nil
        var weeklyWorkOuts: [DayWorkOutModel] = []
        var path = StackState<Path.State>()
        var dynamicHeight: CGFloat = .zero

        @Presents var celebrateState: CelebrateFeature.State?
    }

    enum Action {
        case onAppear
        case didTapNewChallengeButton
        case didTapResetButton
        case setWeeklyWorkOuts
        case updateOwnProgram
        case updateWeekCompleted
        case didTapDayView(item: DayWorkOutModel)
        case path(StackActionOf<Path>)
        case celebrateAction(PresentationAction<CelebrateFeature.Action>)
        case setDynamicHeight(CGFloat)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                let userDefaultsManager = UserDefaultsManager()
                let ownProgram = userDefaultsManager.loadOwnProgram()
                state.ownProgram = ownProgram
                
                return .concatenate(.send(.setWeeklyWorkOuts),
                                    .send(.updateWeekCompleted))
            case .didTapNewChallengeButton:
                let userDefaultsManager = UserDefaultsManager()
                let wodPrograms = userDefaultsManager.loadOfferedPrograms()
                
                if let id = state.ownProgram?.id, let currentWodIndex = wodPrograms.firstIndex(where: { $0.id == id }) {
                    let nextIndex = (currentWodIndex + 1) % wodPrograms.count
                    state.ownProgram = wodPrograms[safe: nextIndex]
                }
                
                return .merge(.send(.setWeeklyWorkOuts),
                              .send(.updateOwnProgram))
            case .didTapResetButton:
                let userDefaultsManager = UserDefaultsManager()
                let wodPrograms = userDefaultsManager.loadOfferedPrograms()
                
                if let id = state.ownProgram?.id {
                    let resetWod = wodPrograms.first { $0.id == id }
                    state.ownProgram = resetWod
                }
                
                return .merge(.send(.setWeeklyWorkOuts),
                              .send(.updateOwnProgram))
            case .setWeeklyWorkOuts:
                state.weeklyWorkOuts = state.ownProgram?.weeklyWorkOuts ?? []
                return .none
            case .updateOwnProgram:
                let userDefaultsManager = UserDefaultsManager()
                userDefaultsManager.saveOwnProgram(with: state.ownProgram)
                
                // TODO: 최근 활동 insert.
                
                return .none
            case .updateWeekCompleted:
                let isCelebrate = state.weeklyWorkOuts.allSatisfy { $0.completedInfo.isCompleted }
                if isCelebrate {
                    state.celebrateState = CelebrateFeature.State()
                }
                return .none
            case let .didTapDayView(item):
                state.path.append(.detail(WorkOutDetailFeature.State(item: item)))
                return .none
            case let .path(action):
                switch action {
                case .element(id: _, action: .detail(.finishWorkOut(let item))):
                    state.path.append(.completed(WorkOutCompletedFeature.State(item: item)))
                    return .none
                case .element(id: _, action: .completed(.didTapCloseButton)):
                    state.path.removeAll()
                    return .none
                default:
                    return .none
                }
            case .celebrateAction:
                return .none
            case let .setDynamicHeight(height):
                state.dynamicHeight = height
                return .none
            }
        }
        .ifLet(\.$celebrateState, action: \.celebrateAction) {
            CelebrateFeature()
        }
        .forEach(\.path, action: \.path)
    }
    
}

import SwiftUI

struct WorkOutView: View {
    
    @Perception.Bindable var store: StoreOf<WorkOutFeature>

    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                ScrollView {
                    VStack(alignment: .leading) {
                        WorkOutNewChallengeView(store: store)
                        WorkOutTitleView(store: store)
                        
                        ForEach(Array(store.weeklyWorkOuts.enumerated()), id: \.element.id) { index, item in
                            WorkOutDayView(index: index, item: item)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    store.send(.didTapDayView(item: item))
                                }
                        }
                        
                        Spacer()
                    }
                    .onAppear {
                        store.send(.onAppear)
                    }
                }
            } destination: { store in
                switch store.case {
                case let .detail(store):
                    WorkOutDetailView(store: store)
                case let .completed(store):
                    WorkOutCompletedView(store: store)
                }
                
            }
            .sheet(item: $store.scope(state: \.celebrateState, action: \.celebrateAction)) { celebrateStore in
                CelebrateView(store: celebrateStore)
                    .presentationDetents([.height(store.state.dynamicHeight + 20.0)])
                    .background {
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    store.send(.setDynamicHeight(proxy.size.height))
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

#Preview {
    WorkOutView(store: Store(initialState: WorkOutFeature.State()) {
        WorkOutFeature()
    })
}
