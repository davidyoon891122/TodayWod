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
        var dayWorkouts: [DayWorkoutModel] = []
        var path = StackState<Path.State>()
        var dynamicHeight: CGFloat = .zero

        @Shared(.inMemory("HideTabBar")) var hideTabBar: Bool = false

        @Presents var celebrateState: CelebrateFeature.State?
    }
    
    @Dependency(\.apiClient) var apiClient
    @Dependency(\.wodClient) var wodClient

    enum Action {
        case onAppear
        case didTapNewChallengeButton
        case didTapResetButton
        case setDayWorkouts
        case updateOwnProgram(ProgramEntity?)
        case updateWeekCompleted
        case didTapDayView(item: DayWorkoutModel)
        case path(StackActionOf<Path>)
        case celebrateAction(PresentationAction<CelebrateFeature.Action>)
        case setDynamicHeight(CGFloat)
        case loadSuccess(ProgramModel)
        case fetchProgramError(Error)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.hideTabBar = false
                return .run { send in
                    do {
                        let currentProgram = try await wodClient.getCurrentProgram() // 코어데이터에서 program 가져옴
                        await send(.loadSuccess(currentProgram))
                    } catch {
                        // TODO: - Load 에러 처리
                        print("error: \(error.localizedDescription)")
                    }
                }
            case .loadSuccess(let programModel):
                state.ownProgram = programModel // 코어데이터에서 가져온 데이터 현재 ownProgram에 set
                
                return .concatenate(.send(.setDayWorkouts),
                                    .send(.updateWeekCompleted))
            case .didTapNewChallengeButton:
                return .run { send in
                    do {
                        let programEntity = try await apiClient.requestProgram(.init(methodType: "machine", level: "advanced"))
                        await send(.updateOwnProgram(programEntity))
                    } catch {
                        await send(.fetchProgramError(error))
                    }
                }
            case .didTapResetButton:
                let userDefaultsManager = UserDefaultsManager()
                let wodPrograms = userDefaultsManager.loadOfferedPrograms()
                
                if let id = state.ownProgram?.id {
                    let resetWod = wodPrograms.first { $0.id == id }
                    state.ownProgram = resetWod
                }
                
                return .merge(.send(.setDayWorkouts),
                              .send(.updateOwnProgram(nil)))
            case .setDayWorkouts:
                state.dayWorkouts = state.ownProgram?.dayWorkouts ?? []
                return .none
            case .updateOwnProgram(let programEntity):
                guard let programEntity = programEntity else { return .none }
                let programModel = ProgramModel(data: programEntity)
                state.ownProgram = programModel
                return .merge(.run { send in
                    do {
                        let _ = try await wodClient.addWodProgram(programModel)
                    } catch {
                        print(error.localizedDescription)
                    }
                }, .send(.setDayWorkouts))
            case .updateWeekCompleted:
                let isCelebrate = state.dayWorkouts.allSatisfy { $0.isCompleted }
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
            case .fetchProgramError(let error):
                print("Fetch error : \(error.localizedDescription)")
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
                        
                        ForEach(Array(store.dayWorkouts.enumerated()), id: \.element.id) { index, item in
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
