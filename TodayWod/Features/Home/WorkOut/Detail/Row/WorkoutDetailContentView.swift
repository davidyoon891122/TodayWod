//
//  WorkoutDetailContentView.swift
//  TodayWod
//
//  Created by D프로젝트노드_오지연 on 10/28/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct WorkoutDetailContentFeature {
    
    @ObservableState
    struct State: Equatable, Identifiable {
        let id: UUID
        var model: WorkoutModel
        
        var wodStates: IdentifiedArrayOf<WodFeature.State> = []
        
        init(hasStart: Bool, model: WorkoutModel) {
            self.id = model.id
            self.model = model
            
            let states = model.wods.map { WodFeature.State(hasStart: hasStart, model: $0) }
            self.wodStates = IdentifiedArrayOf(uniqueElements: states)
        }
    }
    
    enum Action {
        case updateCompleted(Bool)
        case updateUnitText(String)
        case addWodSet
        case removeWodSet(Bool)
        case synchronizeModel(UUID)
        case wodActions(IdentifiedActionOf<WodFeature>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .wodActions(.element(id: id, action: .addWodSet)):
                if let index = state.model.wods.firstIndex(where: { $0.id == id }) {
                    state.model.wods[index].wodSets.append(state.model.wods[index].newWodSet)
                }
                return .send(.addWodSet)
            case let .wodActions(.element(id: id, action: .removeWodSetOf(canRemove))):
                if let index = state.model.wods.firstIndex(where: { $0.id == id }) {
                    if state.model.wods[index].canRemoveSet {
                        state.model.wods[index].wodSets.removeLast()
                    }
                }
                return .send(.removeWodSet(canRemove))
            case let .wodActions(.element(id: id, action: .updateCompleted(isCompleted))):
                return .concatenate(.send(.synchronizeModel(id)),
                                    .send(.updateCompleted(isCompleted)))
            case let .wodActions(.element(id: id, action: .updateUnitText(unit))):
                return .concatenate(.send(.synchronizeModel(id)),
                                    .send(.updateUnitText(unit)))
            case let .synchronizeModel(id):
                if let index = state.model.wods.firstIndex(where: { $0.id == id }),
                let model = state.wodStates[id: id]?.model {
                    state.model.wods[index] = model
                }
                return .none
            case .updateCompleted(_):
                return .none
            case .updateUnitText(_):
                return .none
            case .addWodSet:
                return .none
            case .removeWodSet(_):
                return .none
            case .wodActions(_):
                return .none
            }
        }
        .forEach(\.wodStates, action: \.wodActions) {
            WodFeature()
        }
    }
}

struct WorkoutDetailContentView: View {
    
    @Perception.Bindable var store: StoreOf<WorkoutDetailContentFeature>
    
    var body: some View {
        WithPerceptionTracking {
            Text(store.model.type.title)
                .font(Fonts.Pretendard.bold.swiftUIFont(size: 16))
                .foregroundStyle(Colors.grey100.swiftUIColor)
                .frame(height: 40)
                .padding(.top, 10)
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(store.scope(state: \.wodStates, action: \.wodActions)) { store in
                    WodView(store: store)
                }
            }
        }
    }
    
}

#Preview {
    WorkoutDetailContentView(store: Store(initialState: WorkoutDetailContentFeature.State(hasStart: true, model: WorkoutModel.fake), reducer: {
        WorkoutDetailContentFeature()
    }))
}
