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
        
        @Presents var timerState: BreakTimeFeature.State?
        @Presents var confirmState: WorkoutConfirmationFeature.State?
        
        init(item: DayWorkoutModel) {
            self.item = item
            self.duration = item.duration
            self.hasStart = false
            self.isDayCompleted = false
        }
    }
    
    enum Action: BindableAction {
        case didTapBackButton
        case didTapDoneButton
        case didTapStartButton
        case startTimer
        case stopTimer
        case timerTick
        case setCompleted(WodSetModel)
        case setUnitText(String, WodSetModel)
        case updateWodSet(WodSetModel)
        case saveOwnProgram
        case updateDayCompleted
        case breakTimerAction(PresentationAction<BreakTimeFeature.Action>)
        case binding(BindingAction<State>)
        case confirmAction(PresentationAction<WorkoutConfirmationFeature.Action>)
        case finishWorkOut(DayWorkoutModel)
    }
    
    enum CancelID { case timer }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .didTapBackButton:
                return .run { _ in await dismiss() }
            case .didTapDoneButton:
                state.confirmState = WorkoutConfirmationFeature.State() // 운동 종료 재확인.
                return .none
            case .didTapStartButton:
                state.hasStart = true
                
                // TODO: 운동 시작 시, 최근 활동 저장 필요. (최근 활동 저장 기준 확인 필요.)
                
                return .run { send in
                    await send(.startTimer)
                }
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
            case let .setCompleted(set):
                var updatedSet = set
                updatedSet.isCompleted.toggle()
                
                if updatedSet.isCompleted {
                    state.timerState = BreakTimeFeature.State()
                }
                
                let wodSet = updatedSet
                return .run { send in
                    await send(.updateWodSet(wodSet))
                }
            case let .setUnitText(unitText, set):
                var updatedSet = set
                updatedSet.unitValue = unitText.toInt
                
                let wodSet = updatedSet
                return .run { send in
                    await send(.updateWodSet(wodSet))
                }
            case let .updateWodSet(set):
                outerLoop: for (index, workout) in state.item.workouts.enumerated() {
                    for (wodIndex, wod) in workout.wods.enumerated() {
                        if let setIndex = wod.wodSets.firstIndex(where: { $0.id == set.id }) {
                            state.item.workouts[index].wods[wodIndex].wodSets[setIndex] = set
                            
                            print("%%%%%% UpdateWodSet: \(state.item.workouts)")
                            
                            break outerLoop
                        }
                    }
                }
                return .concatenate(.send(.saveOwnProgram),
                                    .send(.updateDayCompleted))
            case .saveOwnProgram:
                let userDefaultsManager = UserDefaultsManager()
                userDefaultsManager.saveOwnProgram(day: state.item)
                return .none
            case .updateDayCompleted:
                state.isDayCompleted = state.item.isCompleted
                
                if state.isDayCompleted {
                    state.confirmState = WorkoutConfirmationFeature.State() // 운동 완료 재확인.
                    state.timerState = BreakTimeFeature.State()
                }
                return .none
            case .confirmAction(.presented(.didTapDoneButton)):
                state.item.date = Date()
                // TODO: 단순 "운동종료"일 경우엔 Date 저장 필요 없음. isCompleted false.
                // TODO: 운동 성공의 경우, Date 저장.
                
                return .concatenate(.send(.stopTimer),
                                    .send(.saveOwnProgram),
                                    .send(.finishWorkOut(state.item)))
            default:
                return .none
            }
        }
        .ifLet(\.$timerState, action: \.breakTimerAction) {
            BreakTimeFeature()
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
                                    ForEach(store.item.workouts) { workOut in
                                        Text(workOut.type.title)
                                            .font(Fonts.Pretendard.bold.swiftUIFont(size: 16))
                                            .foregroundStyle(Colors.grey100.swiftUIColor)
                                            .frame(height: 40)
                                            .padding(.top, 10)
                                        
                                        VStack(alignment: .leading, spacing: 10) {
                                            ForEach(workOut.wods) { item in
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
                }
                .background(Colors.blue10.swiftUIColor)
                
                if !store.hasStart {
                    BottomButton(title: Constants.buttonTitle) {
                        store.send(.didTapStartButton)
                    }
                    .padding(.horizontal, 38)
                    .padding(.bottom, 20)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .bottomSheet(item: $store.scope(state: \.timerState, action: \.breakTimerAction)) { breakStore in
                BreakTimerView(store: breakStore)
            }
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
