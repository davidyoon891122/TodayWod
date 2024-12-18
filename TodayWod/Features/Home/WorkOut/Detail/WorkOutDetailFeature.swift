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
        @Presents var alert: AlertState<Action.Alert>?

        init(item: DayWorkoutModel) {
            self.item = item
            self.duration = item.duration
            self.hasStart = false
            self.isDoneEnabled = false
            self.isDayCompleted = false
        }
    }
    
    @Dependency(\.wodClient) var wodClient
    
    enum Action: BindableAction {
        case onAppear
        case willDisappear
        case didEnterBackground
        case willEnterForeground
        case setWorkoutStates
        case didTapBackButton
        case didTapDoneButton
        case didTapStartButton
        case startTimer
        case stopTimer
        case timerTick
        case saveOwnProgram
        case saveRecentActivity
        case saveCompletedDate
        case doneWorkout
        case onConfirm(WorkoutConfirmationType)
        case confirmAction(PresentationAction<WorkoutConfirmationFeature.Action>)
        case didTapBreakTimer
        case breakTimerSettingsAction(PresentationAction<BreakTimerSettingsFeature.Action>)
        case resetBreakTimer
        case pauseBreakTimer
        case enterBackgroundBreakTimer
        case resumeBreakTimer
        case workoutActions(IdentifiedActionOf<WorkoutDetailContentFeature>)
        case synchronizeModel(String)
        case binding(BindingAction<State>)
        case setConfirmationViewDynamicHeight(CGFloat)
        case setBreakTimerSettingsViewDynamicHeight(CGFloat)
        case finishWorkOut(DayWorkoutModel)
        case breakTimerAction(BreakTimerFeature.Action)
        case alert(PresentationAction<Alert>)
        
        @CasePathable
        enum Alert: Equatable {
            case didTapUnRemovable
        }
    }
    
    enum CancelID { case timer }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        
        Scope(state: \.breakTimerState, action: \.breakTimerAction) {
            BreakTimerFeature()
        }
        
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                FLog().enter()
                
                state.currentBreakCountDownTime = state.userSetBreakCountDownTime
                state.hideTabBar = true
                return .send(.setWorkoutStates)
            case .willDisappear:
                DLog.d("willDisappear")
                state.hideTabBar = false
                return .concatenate(.send(.stopTimer),
                                    .run { _ in await dismiss() })
            case .didEnterBackground:
                FLog().event("didEnterBackground")
                return .merge(.send(.stopTimer),
                              .send(.enterBackgroundBreakTimer))
            case .willEnterForeground:
                FLog().event("willEnterForeground")
                 
                if state.hasStart {
                    if state.breakTimerState.timerState == .play && state.item.isContainCompleted {
                        return .merge(.send(.startTimer),
                                      .send(.resumeBreakTimer))
                    } else {
                        return .send(.startTimer)
                    }
                } else {
                    return .none
                }
            case .setWorkoutStates:
                let states = state.item.workouts.map { WorkoutDetailContentFeature.State(hasStart: state.hasStart, model: $0) }
                state.workoutStates = IdentifiedArrayOf(uniqueElements: states)
                return .none
            case .didTapBackButton:
                return state.isDoneEnabled ? .send(.onConfirm(.quit)) : .send(.willDisappear)
            case .didTapDoneButton:
                return state.isDayCompleted ? .send(.doneWorkout) : .send(.onConfirm(.quit))
            case .didTapStartButton:
                FLog().tap("start_workout")
                state.hasStart = true
                state.isDoneEnabled = state.item.isContainCompleted
                
                return .merge(.send(.setWorkoutStates),
                              .send(.startTimer))
            case .startTimer:
                return .run { send in
                    while true {
                        try await Task.sleep(for: .seconds(1))
                        await send(.timerTick)
                    }
                }
                .cancellable(id: CancelID.timer)
            case .stopTimer:
                return .cancel(id: CancelID.timer)
            case .timerTick:
                state.duration += 1
                
                state.item.duration = state.duration
                return .none
            case .saveOwnProgram:
                let dayWorkOut = state.item
                return .run { send in
                    do {
                        let _ = try await wodClient.updateWodProgram(dayWorkOut)
                    } catch {
                        DLog.d(error.localizedDescription)
                    }
                }
            case .saveRecentActivity:
                let dayWorkouts = state.item
                return .run { send in
                    do {
                        try await wodClient.addRecentDayWorkouts(dayWorkouts)
                    } catch {
                        DLog.d(error.localizedDescription)
                    }
                }
            case .saveCompletedDate:
                guard let completedDate = state.item.date else { return .none }
                let model = CompletedDateModel(date: completedDate, duration: state.duration)
                return .run { send in
                    do {
                        try await wodClient.addCompletedDates(model)
                    } catch {
                        DLog.d(error.localizedDescription)
                    }
                }
            case .doneWorkout:
                state.item.date = Date() // 운동 완료 Date 저장.
                
                return .concatenate(.send(.stopTimer),
                                    .send(.saveCompletedDate),
                                    .send(.saveOwnProgram),
                                    .send(.saveRecentActivity),
                                    .send(.finishWorkOut(state.item)))
            case let .onConfirm(type):
                FLog().tap(type == .quit ? "quit_workout" : "finish_workout")
                state.confirmState = WorkoutConfirmationFeature.State(type: type) // 운동 종료 재확인.
                return .none
            case .confirmAction(.presented(.didTapDoneButton)): // 운동 완료 or 운동 종료.
                return .send(.doneWorkout)
            case .didTapBreakTimer:
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.prepare()
                generator.impactOccurred()
                
                state.breakTimerSettingsState = BreakTimerSettingsFeature.State()
                return .none
            case .breakTimerSettingsAction(.presented(.didTapMinusButton)):
                return .send(.breakTimerAction(.setDefaultTime))
            case .breakTimerSettingsAction(.presented(.didTapPlusButton)):
                return .send(.breakTimerAction(.setDefaultTime))
            case .breakTimerSettingsAction(.presented(.didTapRecommend)):
                return .send(.breakTimerAction(.setDefaultTime))
            case .breakTimerSettingsAction:
                let hasBreakTimeModified = state.currentBreakCountDownTime != state.userSetBreakCountDownTime
                state.currentBreakCountDownTime = state.userSetBreakCountDownTime
                DLog.d(hasBreakTimeModified)
                if state.isDoneEnabled && hasBreakTimeModified {
                    return .send(.resetBreakTimer)
                } else {
                    return .none
                }
            case .resetBreakTimer:
                return .run { send in
                    await send(.breakTimerAction(.didTapReset))
                }
            case .pauseBreakTimer:
                return .run { send in
                    await send(.breakTimerAction(.stopTimer))
                }
            case .enterBackgroundBreakTimer:
                return .run { send in
                    await send(.breakTimerAction(.enterBackground))
                }
            case .resumeBreakTimer:
                return .run { send in
                    await send(.breakTimerAction(.startTimer))
                }
            case let .workoutActions(.element(id: id, action: .updateCompleted(isCompleted))):
                if isCompleted {
                    return .merge(.send(.resetBreakTimer),
                                  .send(.synchronizeModel(id)))
                } else {
                    return .merge(.send(.pauseBreakTimer),
                                  .send(.synchronizeModel(id)))
                }
            case let .workoutActions(.element(id: id, action: .updateUnitText(_))):
                return .send(.synchronizeModel(id))
            case let .workoutActions(.element(id: id, action: .addWodSet)):
                return .send(.synchronizeModel(id))
            case let .workoutActions(.element(id: id, action: .removeWodSet(disableRemove))):
                
                if disableRemove {
                    state.alert = AlertState {
                        TextState("최소 1세트 이상 진행해야 해요")
                    } actions: {
                        ButtonState(role: .cancel, action: .send(.didTapUnRemovable)) {
                            TextState("확인")
                        }
                    }
                }
                return .send(.synchronizeModel(id))
            case let .synchronizeModel(id):
                // update local item from states
                if let index = state.item.workouts.firstIndex(where: { $0.id == id }),
                let model = state.workoutStates[id: id]?.model {
                    state.item.workouts[index] = model
                }
                // update doneButton state
                state.isDoneEnabled = state.hasStart && state.item.isContainCompleted
                // update day completed
                state.isDayCompleted = state.item.isCompleted
                return state.isDayCompleted ? .send(.onConfirm(.completed)) : .none
            case .setConfirmationViewDynamicHeight(let height):
                state.confirmationViewDynamicHeight = height
                return .none
            case .setBreakTimerSettingsViewDynamicHeight(let height):
                state.breakTimerSettingsViewDynamicHeight = height
                return .none
            case .confirmAction:
                return .none
            case .breakTimerAction:
                return .none
            case .finishWorkOut:
                return .none
            case .binding:
                return .none
            case .workoutActions(_):
                return .none
            case .alert:
                return .none
            }
        }
        .ifLet(\.$confirmState, action: \.confirmAction) {
            WorkoutConfirmationFeature()
        }
        .ifLet(\.$breakTimerSettingsState, action: \.breakTimerSettingsAction) {
            BreakTimerSettingsFeature()
        }
        .ifLet(\.$alert, action: \.alert)
        .forEach(\.workoutStates, action: \.workoutActions) {
            WorkoutDetailContentFeature()
        }
    }
    
}

struct WorkOutDetailView: View {
    
    @Perception.Bindable var store: StoreOf<WorkOutDetailFeature>
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        WithPerceptionTracking {
            ZStack(alignment: .bottom) {
                VStack {
                    WorkOutNavigationView(duration: store.duration, isEnabled: store.isDoneEnabled) {
                        store.send(.didTapBackButton)
                    } doneAction: {
                        store.send(.didTapDoneButton)
                    }
                    
                    ScrollView {
                        ZStack {
                            VStack {
                                WorkOutDetailTitleView(item: store.item)
                                BannerAdView()
                                    .padding(.bottom, 20)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach(store.scope(state: \.workoutStates, action: \.workoutActions)) { store in
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
                        store.send(.didTapStartButton)
                    }
                    .padding(.horizontal, 38)
                    .padding(.bottom, 20)
                }
                
                if store.item.isContainCompleted {
                    BreakTimerView(store: store.scope(state: \.breakTimerState, action: \.breakTimerAction))
                        .onTapGesture {
                            store.send(.didTapBreakTimer)
                        }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .sheet(item: $store.scope(state: \.confirmState, action: \.confirmAction)) { conirmationStore in
                WithPerceptionTracking {
                    WorkoutConfirmationView(store: conirmationStore)
                        .measureHeight { height in
                            store.send(.setConfirmationViewDynamicHeight(height))
                        }
                        .presentationDetents([.height(store.state.confirmationViewDynamicHeight + 20.0)])
                }
            }
            .sheet(item: $store.scope(state: \.breakTimerSettingsState, action: \.breakTimerSettingsAction)) { breakTimerSettingsStore in
                WithPerceptionTracking {
                    BreakTimerSettingsView(store: breakTimerSettingsStore)
                        .measureHeight { height in
                            store.send(.setBreakTimerSettingsViewDynamicHeight(height))
                        }
                        .presentationDetents([.height(store.state.breakTimerSettingsViewDynamicHeight)])
                        .sheetBackground(.clear)
                }
            }
            .alert($store.scope(state: \.alert, action: \.alert))
            .onAppear {
                store.send(.onAppear)
            }
            .onChange(of: scenePhase) { phase in
                switch phase {
                case .active:
                    store.send(.willEnterForeground)
                case .background:
                    store.send(.didEnterBackground)
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
