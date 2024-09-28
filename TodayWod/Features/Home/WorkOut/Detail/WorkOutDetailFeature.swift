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
        var isDayCompleted: Bool = false
    }

    enum Action {
        case setCompleted(WodSet)
        case setUnitText(String, WodSet)
        case updateWodSet(WodSet)
        case updateDayCompleted
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .setCompleted(set):
                var updatedSet = set
                updatedSet.isCompleted.toggle()
                
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
                        
                        print("%%%%%% Update: \(state.item.workOuts)")
                        
                        break outerLoop
                    }
                }
            }
                return .run { send in
                    await send(.updateDayCompleted)
                }
            case .updateDayCompleted:
                state.isDayCompleted = state.item.workOuts.flatMap {
                    $0.items.flatMap {
                        $0.wodSet
                    }
                }.allSatisfy { wodSet in
                    wodSet.isCompleted
                }
                
                if state.isDayCompleted {
                    // TODO: SaveDate, SaveDuration
                    print("isDayCompleted!!!")
                }
                return .none
            }
        }
    }
    
}

struct WorkOutDetailView: View {
    
    @Perception.Bindable var store: StoreOf<WorkOutDetailFeature>
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
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
                .padding(.vertical, 10)
            }
            .background(Colors.blue10.swiftUIColor)
        }
    }
    
}



#Preview {
    WorkOutDetailView(store: Store(initialState: WorkOutDetailFeature.State(item: WorkOutDayModel.fake)) {
        WorkOutDetailFeature()
    })
}
