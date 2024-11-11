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
        case completed(WorkoutCompletedFeature)
    }
    
    @ObservableState
    struct State: Equatable {
        var ownProgram: ProgramModel? = nil
        var dayWorkouts: [DayWorkoutModel] = []
        var path = StackState<Path.State>()
        var dynamicHeight: CGFloat = .zero
        var isEnabledReset: Bool = false
        var toast: ToastModel?

        @Shared(.inMemory(SharedConstants.hideTabBar)) var hideTabBar: Bool = false
        @Shared(.inMemory(SharedConstants.tabType)) var tabType: TabMenuType = .home
        @Shared(.appStorage(SharedConstants.onCelebrate)) var onCelebrate = false

        @Presents var celebrateState: CelebrateFeature.State?
        @Presents var alert: AlertState<Action.Alert>?
    }
    
    @Dependency(\.apiClient) var apiClient
    @Dependency(\.wodClient) var wodClient

    enum Action {
        case onAppear
        case didTapNewChallengeButton
        case setNewChallenge
        case didTapResetButton
        case setDayWorkouts
        case updateOwnProgram(ProgramEntity?)
        case updateWeekCompleted
        case didTapDayView(item: DayWorkoutModel)
        case path(StackActionOf<Path>)
        case celebrateAction(PresentationAction<CelebrateFeature.Action>)
        case setDynamicHeight(CGFloat)
        case loadResult(Result<ProgramModel, Error>)
        case fetchProgramError(Error)
        case alert(PresentationAction<Alert>)
        case setToast(ToastModel?)
        
        @CasePathable
        enum Alert: Equatable {
            case startNewChallenge
            case resetProgram
        }
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.hideTabBar = false
                return .run { send in
                    do {
                        let currentProgram = try await wodClient.getCurrentProgram() // 코어데이터에서 program 가져옴
                        await send(.loadResult(.success(currentProgram)))
                    } catch {
                        await send(.loadResult(.failure(error)))
                    }
                }
            case .loadResult(.success(let programModel)):
                state.ownProgram = programModel // 코어데이터에서 가져온 데이터 현재 ownProgram에 set
                state.isEnabledReset = programModel.isEnabledReset
                
                return .concatenate(.send(.setDayWorkouts),
                                    .send(.updateWeekCompleted))
            case .loadResult(.failure(let error)):
                return .send(.setToast(.init(message: error.localizedDescription)))
            case .didTapNewChallengeButton:
                state.alert = AlertState {
                    TextState("새로운 도전")
                } actions: {
                    ButtonState(role: .destructive) {
                        TextState("취소")
                    }
                    ButtonState(role: .cancel, action: .send(.startNewChallenge)) {
                        TextState("확인")
                    }
                } message: {
                    TextState("새로운 운동 루틴을 만들어요")
                }
                return .none
            case .alert(.presented(.startNewChallenge)):
                return .send(.setNewChallenge)
            case .setNewChallenge:
                state.onCelebrate = false
                guard let program = state.ownProgram else { return .none }
                return .run { send in
                    do {
                        let programEntity = try await apiClient.requestOtherRandomProgram(.init(methodType: program.methodType.rawValue, level: program.level.rawValue, id: program.id))
                        await send(.updateOwnProgram(programEntity))
                    } catch {
                        await send(.fetchProgramError(error))
                    }
                }
            case .didTapResetButton:
                state.alert = AlertState {
                    TextState("운동 초기화")
                } actions: {
                    ButtonState(role: .destructive) {
                        TextState("취소")
                    }
                    ButtonState(role: .cancel, action: .send(.resetProgram)) {
                        TextState("확인")
                    }
                } message: {
                    TextState("완료한 운동을 초기화 해요")
                }
                return .none
            case .alert(.presented(.resetProgram)):
                guard let program = state.ownProgram else { return .none }

                return .run { send in
                    do {
                        let programEntity = try await apiClient.requestCurrentProgram(.init(methodType: program.methodType.rawValue, level: program.level.rawValue), "\(program.id)")
                        await send(.updateOwnProgram(programEntity))
                    } catch {
                        await send(.fetchProgramError(error))
                    }
                }
            case .setDayWorkouts:
                state.dayWorkouts = state.ownProgram?.dayWorkouts ?? []
                return .none
            case .updateOwnProgram(let programEntity):
                guard let programEntity = programEntity else { return .none }
                let programModel = ProgramModel(data: programEntity)
                state.ownProgram = programModel
                state.isEnabledReset = programModel.isEnabledReset
                
                return .merge(.run { send in
                    do {
                        let _ = try await wodClient.addWodProgram(programModel)
                    } catch {
                        await send(.setToast(.init(message: error.localizedDescription)))
                    }
                }, .send(.setDayWorkouts))
            case .updateWeekCompleted:
                let isCelebrate = state.dayWorkouts.allSatisfy { $0.isCompleted }
                if isCelebrate, !state.onCelebrate {
                    state.onCelebrate = true
                    state.celebrateState = CelebrateFeature.State()
                }
                return .none
            case .celebrateAction(.presented(.didTapNewChallengeButton)):
                return .send(.setNewChallenge)
            case let .didTapDayView(item):
                if item.isCompleted {
                    state.path.append(.completed(WorkoutCompletedFeature.State(item: item)))
                } else {
                    state.path.append(.detail(WorkOutDetailFeature.State(item: item)))
                }
                return .none
            case let .path(action):
                switch action {
                case .element(id: _, action: .detail(.finishWorkOut(let item))):
                    state.path.append(.completed(WorkoutCompletedFeature.State(item: item)))
                    return .none
                case .element(id: _, action: .completed(.didTapCloseButton)):
                    state.tabType = .settings
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
                return .send(.setToast(.init(message: error.localizedDescription)))
            case .alert:
                return .none
            case .setToast(let toast):
                state.toast = toast
                return .none
            }
        }
        .ifLet(\.$celebrateState, action: \.celebrateAction) {
            CelebrateFeature()
        }
        .ifLet(\.alert, action: \.alert)
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
                    LazyVStack(alignment: .leading) {
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
                    WorkoutCompletedView(store: store)
                }
                
            }
            .toolbar(.hidden, for: .navigationBar)
            .sheet(item: $store.scope(state: \.celebrateState, action: \.celebrateAction)) { celebrateStore in
                CelebrateView(store: celebrateStore)
                    .measureHeight { height in
                        store.send(.setDynamicHeight(height))
                    }
                    .presentationDetents([.height(store.state.dynamicHeight + 20.0)])
            }
            .alert($store.scope(state: \.alert, action: \.alert))
            .toastView(toast: $store.toast.sending(\.setToast))
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
