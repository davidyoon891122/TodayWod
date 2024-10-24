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
        var isDayCompleted: Bool
        
        var breakTimerState: BreakTimeFeature.State = BreakTimeFeature.State()

        @Shared(.inMemory("HideTabBar")) var hideTabBar: Bool = true
        @Presents var confirmState: WorkoutConfirmationFeature.State?
        
        init(item: DayWorkoutModel) {
            self.item = item
            self.duration = item.duration
            self.hasStart = false
            self.isDayCompleted = false
        }
    }
    
    @Dependency(\.wodClient) var wodClient
    
    enum Action: BindableAction {
        case onAppear
        case didTapBackButton
        case didTapDoneButton
        case didTapStartButton
        case startTimer
        case stopTimer
        case timerTick
        case setCompleted(Bool)
        case updateWodSet
        case saveOwnProgram
        case saveRecentActivity
        case updateDayCompleted
        case saveCompletedDate
        case confirmAction(PresentationAction<WorkoutConfirmationFeature.Action>)
        case finishWorkOut(DayWorkoutModel)
        case binding(BindingAction<State>)
        case breakTimerAction(BreakTimeFeature.Action)
        case resetTimer
    }
    
    enum CancelID { case timer }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        
        Scope(state: \.breakTimerState, action: \.breakTimerAction) {
            BreakTimeFeature()
        }
        
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.hideTabBar = true
                return .none
            case .didTapBackButton:
                return .run { _ in await dismiss() }
            case .didTapDoneButton:
                if state.hasStart {
                    state.confirmState = WorkoutConfirmationFeature.State(type: .quit) // 운동 종료 재확인.
                    return .none
                } else {
                    return .run { _ in await dismiss() }
                }
            case .didTapStartButton:
                state.hasStart = true
                return .send(.startTimer)
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
                return .run { send in
                    await send(.saveOwnProgram)
                }
            case let .setCompleted(isCompleted):
                return .send(.updateWodSet)
            case .updateWodSet:
                return .concatenate(.send(.saveOwnProgram),
                                    .send(.updateDayCompleted))
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
            case .updateDayCompleted:
                state.isDayCompleted = state.item.isCompleted
                
                if state.isDayCompleted {
                    state.confirmState = WorkoutConfirmationFeature.State(type: .completed) // 운동 완료 재확인.
                    return .send(.saveCompletedDate)
                }
                return .none
            case .saveCompletedDate:
                let completedDate = CompletedDateModel(date: Date(), duration: state.duration)
                return .run { send in
                    do {
                        try await wodClient.addCompletedDates(completedDate)
                    } catch {
                        DLog.d(error.localizedDescription)
                    }
                }
            case .confirmAction(.presented(.didTapDoneButton)):
                return .concatenate(.send(.stopTimer),
                                    .send(.saveOwnProgram),
                                    .send(.saveRecentActivity),
                                    .send(.finishWorkOut(state.item)))
            case .breakTimerAction:
                return .none
            case .resetTimer:
                return .run { send in
                    await send(.breakTimerAction(.didTapReset))
                }
            default:
                return .none
            }
        }
        .ifLet(\.$confirmState, action: \.confirmAction) {
            WorkoutConfirmationFeature()
        }
    }
    
}

struct WorkOutDetailView: View {
    
    @Perception.Bindable var store: StoreOf<WorkOutDetailFeature>
    
    @State private var dynamicHeight: CGFloat = .zero
    
    var body: some View {
        WithPerceptionTracking {
            ZStack(alignment: .bottom) {
                VStack {
                    WorkOutNavigationView(duration: store.duration) {
                        store.send(.didTapBackButton)
                    } doneAction: {
                        store.send(.didTapDoneButton)
                    }
                    
                    ScrollView {
                        ZStack {
                            VStack {
                                WorkOutDetailTitleView(item: store.item)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach($store.item.workouts, id: \.self.id) { workout in
                                        
                                        let workoutValue = workout.wrappedValue
                                        
                                        Text(workoutValue.type.title)
                                            .font(Fonts.Pretendard.bold.swiftUIFont(size: 16))
                                            .foregroundStyle(Colors.grey100.swiftUIColor)
                                            .frame(height: 40)
                                            .padding(.top, 10)
                                        
                                        VStack(alignment: .leading, spacing: 10) {
                                            ForEach(workout.wods) { item in
                                                WodView(store: store, model: item)
                                            }
                                        }
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
                } else {
                    BreakTimerView(store: store.scope(state: \.breakTimerState, action: \.breakTimerAction))
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .sheet(item: $store.scope(state: \.confirmState, action: \.confirmAction)) { store in
                WorkoutConfirmationView(store: store)
                    .presentationDetents([.height(dynamicHeight + 20.0)])
                    .background {
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    dynamicHeight = proxy.size.height
                                }
                        }
                    }
            }
            .onAppear {
                store.send(.onAppear)
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
