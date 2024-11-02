//
//  WodView.swift
//  TodayWod
//
//  Created by 오지연 on 9/21/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

@Reducer
struct WodFeature {
    
    @ObservableState
    struct State: Equatable, Identifiable {
        let id: UUID
        let hasStart: Bool
        var model: WodModel
        
        var wodSetStates: IdentifiedArrayOf<WodSetFeature.State> = []
        
        init(hasStart: Bool, model: WodModel) {
            self.id = model.id
            self.hasStart = hasStart
            self.model = model
            
            let states = model.wodSets.map { WodSetFeature.State(hasStart: hasStart, isOrderSetVisible: model.isOrderSetVisible, model: $0) }
            self.wodSetStates = IdentifiedArrayOf(uniqueElements: states)
        }
    }
    
    enum Action {
        case updateCompleted(Bool)
        case updateUnitText(String)
        case addWodSetOf(WodSetModel)
        case addWodSet
        case removeWodSetOf(disableRemove: Bool)
        case removeWodSet
        case wodSetActions(IdentifiedActionOf<WodSetFeature>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .wodSetActions(.element(id: id, action: .updateCompleted(isCompleted))):
                if let index = state.model.wodSets.firstIndex(where: { $0.id == id }) {
                    state.model.wodSets[index].isCompleted = isCompleted
                }
                return .send(.updateCompleted(isCompleted))
            case let .wodSetActions(.element(id: id, action: .updateUnitText(unit))):
                if let index = state.model.wodSets.firstIndex(where: { $0.id == id }) {
                    state.model.wodSets[index].unitValue = unit.toInt
                }
                return .send(.updateUnitText(unit))
            case .addWodSet:
                let newWodSet = state.model.newWodSet
                
                let wodSetState = WodSetFeature.State(hasStart: state.hasStart, isOrderSetVisible: state.model.isOrderSetVisible, model: newWodSet)
                state.wodSetStates.append(wodSetState)
                
                state.model.wodSets.append(newWodSet) // local newWodSet order을 위한 처리.
                
                return .send(.addWodSetOf(newWodSet))
            case .removeWodSet:
                let disableRemove = !state.model.canRemoveSet
                if state.model.canRemoveSet {
                    state.wodSetStates.removeLast()
                    
                    state.model.wodSets.removeLast() // local newWodSet order을 위한 처리.
                }
                return .send(.removeWodSetOf(disableRemove: disableRemove))
            case .updateCompleted(_):
                return .none
            case .updateUnitText(_):
                return .none
            case .removeWodSetOf(_):
                return .none
            case .addWodSetOf(_):
                return .none
            case .wodSetActions(_):
                return .none
            }
        }
        .forEach(\.wodSetStates, action: \.wodSetActions) {
            WodSetFeature()
        }
    }
    
}

struct WodView: View {
    
    @Perception.Bindable var store: StoreOf<WodFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack(alignment: .leading) {
                titleView
                
                headerView
                
                VStack(spacing: 10) {
                    ForEach(store.scope(state: \.wodSetStates, action: \.wodSetActions)) { store in
                        WodSetView(store: store)
                    }
                    
                    if store.model.isOrderSetVisible { // 세트 추가 삭제.
                        HStack {
                            Text("+ 세트 추가")
                                .font(Fonts.Pretendard.bold.swiftUIFont(size: 16))
                                .foregroundStyle(Colors.grey60.swiftUIColor)
                                .onTapGesture {
                                    store.send(.addWodSet)
                                }
                            Spacer()
                            Text("- 세트 삭제")
                                .font(Fonts.Pretendard.bold.swiftUIFont(size: 16))
                                .foregroundStyle(Colors.grey60.swiftUIColor)
                                .onTapGesture {
                                    store.send(.removeWodSet)
                                }
                        }
                        .frame(height: 44.0)
                        .padding(.horizontal, 10)
                    }
                }
            }
            .padding(20)
            .background(.white)
            .cornerRadius(12, corners: .allCorners)
        }
    }
    
    var titleView: some View {
        VStack(alignment: .leading) {
            Text(store.model.title)
                .font(Fonts.Pretendard.bold.swiftUIFont(size: 20))
                .foregroundStyle(Colors.grey100.swiftUIColor)
                .frame(height: 28)
            Text(store.model.subTitle)
                .font(Fonts.Pretendard.bold.swiftUIFont(size: 16))
                .foregroundStyle(Colors.grey70.swiftUIColor)
        }
        .padding(.bottom, 20)
    }
    
    var headerView: some View {
        HStack(spacing: 10) {
            if store.model.isOrderSetVisible {
                Text(store.model.displaySet)
                    .font(Fonts.Pretendard.medium.swiftUIFont(size: 12))
                    .foregroundStyle(Colors.grey100.swiftUIColor)
            }
            Text(store.model.unit.displayTitle)
                .font(Fonts.Pretendard.medium.swiftUIFont(size: 12))
                .foregroundStyle(Colors.grey100.swiftUIColor)
            Spacer()
            Text("완료")
                .font(Fonts.Pretendard.medium.swiftUIFont(size: 12))
                .foregroundStyle(Colors.grey100.swiftUIColor)
                .frame(width: 48)
        }
        .padding(.bottom, 10)
    }
    
}

#Preview {
    VStack {
        Spacer()
        WodView(store: Store(initialState: WodFeature.State(hasStart: true, model: WodModel.fake), reducer: {
            WodFeature()
        }))
        Spacer()
    }
    .background(.blue10)
}
