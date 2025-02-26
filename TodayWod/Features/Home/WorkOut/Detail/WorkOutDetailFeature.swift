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
        var item: DayWorkoutModel
        var duration: Int
        var hasStart: Bool
        var isDoneEnabled: Bool
        var isDayCompleted: Bool
        
        var workoutStates: IdentifiedArrayOf<WorkoutDetailContentFeature.State> = []
        
        var breakTimerState: BreakTimerFeature.State = BreakTimerFeature.State()

        var confirmationViewDynamicHeight: CGFloat = 0
        var breakTimerSettingsViewDynamicHeight: CGFloat = 0
        // 현재 보여지고 있는 휴식시간의 값(현재 값과 변경된 값 비교를 위해 사용)
        var currentBreakCountDownTime: Int = 60

        // 유저가 세팅하여 변경된 휴식시간의 값
        @Shared(.appStorage(SharedConstants.breakTime)) var userSetBreakCountDownTime: Int = 60
        @Shared(.inMemory(SharedConstants.hideTabBar)) var hideTabBar: Bool = true
        @Presents var confirmState: WorkoutConfirmationFeature.State?
        @Presents var breakTimerSettingsState: BreakTimerSettingsFeature.State?
        @Presents var alert: AlertState<ScopeAction.Alert>?

        init(item: DayWorkoutModel) {
            self.item = item
            self.duration = item.duration
            self.hasStart = false
            self.isDoneEnabled = false
            self.isDayCompleted = false
        }
    }
    
    @Dependency(\.wodClient) var wodClient
    
    enum Action: FeatureAction, BindableAction {
        case view(ViewAction)
        case inner(InnerAction)
        case scope(ScopeAction)
        case delegate(DelegateAction)
        case binding(BindingAction<State>)
    }
    
    enum ViewAction: Equatable {
        case onAppear
        case willDisappear
        case didEnterBackground
        case willEnterForeground
        
        case didTapBackButton
        case didTapDoneButton
        case didTapStartButton
        case didTapBreakTimer
        
        case setConfirmationViewDynamicHeight(CGFloat)
        case setBreakTimerSettingsViewDynamicHeight(CGFloat)
    }
    
    enum InnerAction: Equatable {
        case setWorkoutStates
        case startTimer
        case stopTimer
        case timerTick
        case resetBreakTimer
        case pauseBreakTimer
        case enterBackgroundBreakTimer
        case resumeBreakTimer
        case saveOwnProgram
        case saveRecentActivity
        case saveCompletedDate
        case doneWorkout
        case synchronizeModel(String)
        case onConfirm(WorkoutConfirmationType)
    }
    
    @CasePathable
    enum ScopeAction {
        case confirmAction(PresentationAction<WorkoutConfirmationFeature.Action>)
        case breakTimerSettingsAction(PresentationAction<BreakTimerSettingsFeature.Action>)
        case workoutActions(IdentifiedActionOf<WorkoutDetailContentFeature>)
        case alert(PresentationAction<Alert>)
        case breakTimerAction(BreakTimerFeature.Action)
        
        @CasePathable
        enum Alert: Equatable {
            case didTapUnRemovable
        }
    }
    
    enum DelegateAction {
        case finishWorkOut(DayWorkoutModel)
    }
    
    enum CancelID { case timer }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        
        Scope(state: \.breakTimerState, action: \.scope.breakTimerAction) {
            BreakTimerFeature()
        }
        
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .view(.onAppear):
                FLog().enter()
                
                state.currentBreakCountDownTime = state.userSetBreakCountDownTime
                state.hideTabBar = true
                return .send(.inner(.setWorkoutStates))
            case .view(.willDisappear):
                DLog.d("willDisappear")
                state.hideTabBar = false
                return .concatenate(.send(.inner(.stopTimer)),
                                    .run { _ in await dismiss() })
            case .view(.didEnterBackground):
                FLog().event("didEnterBackground")
                return .merge(.send(.inner(.stopTimer)),
                              .send(.inner(.enterBackgroundBreakTimer)))
            case .view(.willEnterForeground):
                FLog().event("willEnterForeground")
                 
                if state.hasStart {
                    if state.breakTimerState.timerState == .play && state.item.isContainCompleted {
                        return .merge(.send(.inner(.startTimer)),
                                      .send(.inner(.resumeBreakTimer)))
                    } else {
                        return .send(.inner(.startTimer))
                    }
                } else {
                    return .none
                }
            
            case .view(.didTapBackButton):
                return state.isDoneEnabled ? .send(.inner(.onConfirm(.quit))) : .send(.view(.willDisappear))
            case .view(.didTapDoneButton):
                return state.isDayCompleted ? .send(.inner(.doneWorkout)) : .send(.inner(.onConfirm(.quit)))
            case .view(.didTapStartButton):
                FLog().tap("start_workout")
                state.hasStart = true
                state.isDoneEnabled = state.item.isContainCompleted
                
                return .merge(.send(.inner(.setWorkoutStates)),
                              .send(.inner(.startTimer)))
            case .view(.didTapBreakTimer):
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.prepare()
                generator.impactOccurred()
                
                state.breakTimerSettingsState = BreakTimerSettingsFeature.State()
                return .none
            case .view(.setConfirmationViewDynamicHeight(let height)):
                state.confirmationViewDynamicHeight = height
                return .none
            case .view(.setBreakTimerSettingsViewDynamicHeight(let height)):
                state.breakTimerSettingsViewDynamicHeight = height
                return .none
            case .inner(.setWorkoutStates):
                let states = state.item.workouts.map { WorkoutDetailContentFeature.State(hasStart: state.hasStart, model: $0) }
                state.workoutStates = IdentifiedArrayOf(uniqueElements: states)
                return .none
            case .inner(.startTimer):
                return .run { send in
                    while true {
                        try await Task.sleep(for: .seconds(1))
                        await send(.inner(.timerTick))
                    }
                }
                .cancellable(id: CancelID.timer)
            case .inner(.stopTimer):
                return .cancel(id: CancelID.timer)
            case .inner(.timerTick):
                state.duration += 1
                
                state.item.duration = state.duration
                return .none
            case .inner(.resetBreakTimer):
                return .run { send in
                    await send(.scope(.breakTimerAction(.didTapReset)))
                }
            case .inner(.pauseBreakTimer):
                return .run { send in
                    await send(.scope(.breakTimerAction(.stopTimer)))
                }
            case .inner(.enterBackgroundBreakTimer):
                return .run { send in
                    await send(.scope(.breakTimerAction(.enterBackground)))
                }
            case .inner(.resumeBreakTimer):
                return .run { send in
                    await send(.scope(.breakTimerAction(.startTimer)))
                }
            case .inner(.saveOwnProgram):
                let dayWorkOut = state.item
                return .run { send in
                    do {
                        let _ = try await wodClient.updateWodProgram(dayWorkOut)
                    } catch {
                        DLog.d(error.localizedDescription)
                    }
                }
            case .inner(.saveRecentActivity):
                let dayWorkouts = state.item
                return .run { send in
                    do {
                        try await wodClient.addRecentDayWorkouts(dayWorkouts)
                    } catch {
                        DLog.d(error.localizedDescription)
                    }
                }
            case .inner(.saveCompletedDate):
                guard let completedDate = state.item.date else { return .none }
                let model = CompletedDateModel(date: completedDate, duration: state.duration)
                return .run { send in
                    do {
                        try await wodClient.addCompletedDates(model)
                    } catch {
                        DLog.d(error.localizedDescription)
                    }
                }
            case .inner(.doneWorkout):
                state.item.date = Date() // 운동 완료 Date 저장.
                
                return .concatenate(.send(.inner(.stopTimer)),
                                    .send(.inner(.saveCompletedDate)),
                                    .send(.inner(.saveOwnProgram)),
                                    .send(.inner(.saveRecentActivity)),
                                    .send(.delegate(.finishWorkOut(state.item))))
            case let .inner(.synchronizeModel(id)):
                // update local item from states
                if let index = state.item.workouts.firstIndex(where: { $0.id == id }),
                let model = state.workoutStates[id: id]?.model {
                    state.item.workouts[index] = model
                }
                // update doneButton state
                state.isDoneEnabled = state.hasStart && state.item.isContainCompleted
                // update day completed
                state.isDayCompleted = state.item.isCompleted
                return state.isDayCompleted ? .send(.inner(.onConfirm(.completed))) : .none
            case let .inner(.onConfirm(type)):
                FLog().tap(type == .quit ? "quit_workout" : "finish_workout")
                state.confirmState = WorkoutConfirmationFeature.State(type: type) // 운동 종료 재확인.
                return .none
            case .scope(.confirmAction(.presented(.didTapDoneButton))): // 운동 완료 or 운동 종료.
                return .send(.inner(.doneWorkout))
            case .scope(.breakTimerSettingsAction(.presented(.didTapMinusButton))):
                return .send(.scope(.breakTimerAction(.setDefaultTime)))
            case .scope(.breakTimerSettingsAction(.presented(.didTapPlusButton))):
                return .send(.scope(.breakTimerAction(.setDefaultTime)))
            case .scope(.breakTimerSettingsAction(.presented(.didTapRecommend))):
                return .send(.scope(.breakTimerAction(.setDefaultTime)))
            case .scope(.breakTimerSettingsAction):
                let hasBreakTimeModified = state.currentBreakCountDownTime != state.userSetBreakCountDownTime
                state.currentBreakCountDownTime = state.userSetBreakCountDownTime
                DLog.d(hasBreakTimeModified)
                if state.isDoneEnabled && hasBreakTimeModified {
                    return .send(.inner(.resetBreakTimer))
                } else {
                    return .none
                }
            case let .scope(.workoutActions(.element(id: id, action: .updateCompleted(isCompleted)))):
                if isCompleted {
                    return .merge(.send(.inner(.resetBreakTimer)),
                                  .send(.inner(.synchronizeModel(id))))
                } else {
                    return .merge(.send(.inner(.pauseBreakTimer)),
                                  .send(.inner(.synchronizeModel(id))))
                }
            case let .scope(.workoutActions(.element(id: id, action: .updateUnitText(_)))):
                return .send(.inner(.synchronizeModel(id)))
            case let .scope(.workoutActions(.element(id: id, action: .addWodSet))):
                return .send(.inner(.synchronizeModel(id)))
            case let .scope(.workoutActions(.element(id: id, action: .removeWodSet(disableRemove)))):
                if disableRemove {
                    state.alert = AlertState {
                        TextState("최소 1세트 이상 진행해야 해요")
                    } actions: {
                        ButtonState(role: .cancel, action: .send(.didTapUnRemovable)) {
                            TextState("확인")
                        }
                    }
                }
                return .send(.inner(.synchronizeModel(id)))
            case .scope(.confirmAction):
                return .none
            case .scope(.breakTimerAction):
                return .none
            case .scope(.workoutActions(_)):
                return .none
            case .scope(.alert):
                return .none
            case .delegate(.finishWorkOut):
                return .none
            case .binding:
                return .none
            }
        }
        .ifLet(\.$confirmState, action: \.scope.confirmAction) {
            WorkoutConfirmationFeature()
        }
        .ifLet(\.$breakTimerSettingsState, action: \.scope.breakTimerSettingsAction) {
            BreakTimerSettingsFeature()
        }
        .ifLet(\.$alert, action: \.scope.alert)
        .forEach(\.workoutStates, action: \.scope.workoutActions) {
            WorkoutDetailContentFeature()
        }
    }
    
}

struct WorkOutDetailView: View {
    
    @Perception.Bindable var store: StoreOf<WorkOutDetailFeature>
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text("d")
        WithPerceptionTracking {
            ZStack(alignment: .bottom) {
                VStack {
                    WorkOutNavigationView(duration: store.duration, isEnabled: store.isDoneEnabled) {
                        store.sendViewAction(.didTapBackButton)
                    } doneAction: {
                        store.sendViewAction(.didTapDoneButton)
                    }
                    
                    ScrollView {
                        ZStack {
                            VStack {
                                WorkOutDetailTitleView(item: store.item)
                                BannerAdView()
                                    .padding(.bottom, 20)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach(store.scope(state: \.workoutStates, action: \.scope.workoutActions)) { store in
                                        WorkoutDetailContentView(store: store)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 149)
                        }
                    }
                    .scrollDismissesKeyboard(.immediately)
                }
                .background(Colors.blue10.swiftUIColor)
                
                if !store.hasStart {
                    BottomButton(title: Constants.buttonTitle) {
                        store.sendViewAction(.didTapStartButton)
                    }
                    .padding(.horizontal, 38)
                    .padding(.bottom, 20)
                }
                
                if store.item.isContainCompleted {
                    BreakTimerView(store: store.scope(state: \.breakTimerState, action: \.scope.breakTimerAction))
                        .onTapGesture {
                            store.sendViewAction(.didTapBreakTimer)
                        }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .sheet(item: $store.scope(state: \.confirmState, action: \.scope.confirmAction)) { confirmationStore in
                WithPerceptionTracking {
                    WorkoutConfirmationView(store: confirmationStore)
                        .measureHeight { height in
                            store.sendViewAction(.setConfirmationViewDynamicHeight(height))
                        }
                        .presentationDetents([.height(store.state.confirmationViewDynamicHeight + 20.0)])
                }
            }
            .sheet(item: $store.scope(state: \.breakTimerSettingsState, action: \.scope.breakTimerSettingsAction)) { breakTimerSettingsStore in
                WithPerceptionTracking {
                    BreakTimerSettingsView(store: breakTimerSettingsStore)
                        .measureHeight { height in
                            store.sendViewAction(.setBreakTimerSettingsViewDynamicHeight(height))
                        }
                        .presentationDetents([.height(store.state.breakTimerSettingsViewDynamicHeight)])
                        .sheetBackground(.clear)
                }
            }
            .alert($store.scope(state: \.alert, action: \.scope.alert))
            .onAppear {
                store.sendViewAction(.onAppear)
            }
            .onChange(of: scenePhase) { phase in
                switch phase {
                case .active:
                    store.sendViewAction(.willEnterForeground)
                case .background:
                    store.sendViewAction(.didEnterBackground)
                default:
                    break
                }
            }
        }
    }
}

private extension WorkOutDetailView {
    
    enum Constants {
        static let buttonTitle = "운동 시작하기"
    }
    
}

#Preview {
    WorkOutDetailView(store: Store(initialState: WorkOutDetailFeature.State(item: DayWorkoutModel.fake)) {
        WorkOutDetailFeature()
    })
}
