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
        var item: WorkOutDayModel
        var duration: Int = 0
        var hasStart: Bool = false
        var isDayCompleted: Bool = false
        var isPresented: Bool = false
        
        @Presents var timerState: BreakTimeFeature.State?
    }
    
    enum Action: BindableAction {
        case didTapBackButton
        case didTapDoneButton
        case didTapStartButton
        case startTimer
        case timerTick
        case setCompleted(WodSet)
        case setUnitText(String, WodSet)
        case updateWodSet(WodSet)
        case saveWorkOutOfDay
        case updateDayCompleted
        case breakTimerAction(PresentationAction<BreakTimeFeature.Action>)
        case binding(BindingAction<State>)
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
                return .cancel(id: CancelID.timer)
            case .didTapStartButton:
                state.hasStart = true
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
            case .timerTick:
                state.duration += 1
                return .none
            case let .setCompleted(set):
                var updatedSet = set
                updatedSet.isCompleted.toggle()
                
                if updatedSet.isCompleted {
                    state.isPresented = true // 휴식 시작.
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
            outerLoop: for (index, workout) in state.item.workOuts.enumerated() {
                for (wodIndex, wod) in workout.items.enumerated() {
                    if let setIndex = wod.wodSet.firstIndex(where: { $0.id == set.id }) {
                        state.item.workOuts[index].items[wodIndex].wodSet[setIndex] = set
                        
                        print("%%%%%% UpdateWodSet: \(state.item.workOuts)")
                        
                        break outerLoop
                    }
                }
            }
                return .concatenate(.send(.saveWorkOutOfDay),
                                    .send(.updateDayCompleted))
            case .saveWorkOutOfDay:
                let userDefaultsManager = UserDefaultsManager()
                userDefaultsManager.saveWodInfo(day: state.item)
                return .none
            case .updateDayCompleted:
                state.isDayCompleted = state.item.workOuts.flatMap {
                    $0.items.flatMap { $0.wodSet }
                }.allSatisfy { wodSet in
                    wodSet.isCompleted
                }
                
                if state.isDayCompleted {
                    // TODO: 운동을 완료할까요? BottomSheet 호출
                    // TODO: completedInfo에 SaveDate, SaveDuration 함께 저장.
                    state.item.completedInfo = .init(isCompleted: true)
                    
                    let userDefaultsManager = UserDefaultsManager()
                    userDefaultsManager.saveWodInfo(day: state.item)
                    
                    print("isDayCompleted!!!")
                }
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
    
    @State private var duration: Int = 0
    @State private var isPresented: Bool = false
    
    var body: some View {
        WithPerceptionTracking {
            ZStack(alignment: .bottom) {
                VStack {
                    WorkOutNavigationView(duration: $duration) {
                        store.send(.didTapBackButton)
                    } doneAction: {
                        store.send(.didTapDoneButton)
                    }
                    
                    ScrollView {
                        ZStack {
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
                    Button(action: {
                        store.send(.didTapStartButton)
                    }, label: {
                        Text(Constants.buttonTitle)
                    })
                    .bottomButtonStyle()
                    .padding(.horizontal, 38)
                    .padding(.bottom, 20)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .bind($store.isPresented, to: $isPresented)
            .bind($store.duration, to: $duration)
            .bottomSheet(isPresented: $isPresented) {
                BreakTimerView(store: Store(initialState: BreakTimeFeature.State()) {
                    BreakTimeFeature()
                })
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
    WorkOutDetailView(store: Store(initialState: WorkOutDetailFeature.State(item: WorkOutDayModel.fake)) {
        WorkOutDetailFeature()
    })
}
