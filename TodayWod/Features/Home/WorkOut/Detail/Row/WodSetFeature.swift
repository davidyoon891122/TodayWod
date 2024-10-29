//
//  WodSetFeature.swift
//  TodayWod
//
//  Created by 오지연 on 9/22/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct WodSetFeature {
    
    @ObservableState
    struct State: Equatable, Identifiable {
        var unitText: String = ""
        
        let id: UUID
        let hasStart: Bool
        let isOrderSetVisible: Bool
        var model: WodSetModel
        
        init(hasStart: Bool, isOrderSetVisible: Bool, model: WodSetModel) {
            self.id = model.id
            self.hasStart = hasStart
            self.isOrderSetVisible = isOrderSetVisible
            self.model = model
            
            self.unitText = model.displayUnitValue
        }
    }
    
    enum Action {
        case setCompleted
        case updateCompleted(Bool)
        case setUnitText(String)
        case updateUnitText(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .setCompleted:
                state.model.isCompleted.toggle()
                return .send(.updateCompleted(state.model.isCompleted))
            case .updateCompleted(_):
                return .none
            case let .setUnitText(text):
                state.unitText = text
                return .send(.updateUnitText(state.unitText))
            case .updateUnitText(_):
                return .none
            }
        }
    }
}

struct WodSetView: View {
    
    @Perception.Bindable var store: StoreOf<WodSetFeature>
    
    var body: some View {
        WithPerceptionTracking {
            HStack(spacing: 10) {
                if store.isOrderSetVisible {
                    Text(store.model.displaySetNumber)
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 18))
                        .foregroundStyle(Colors.grey100.swiftUIColor)
                        .frame(width: 48)
                }
                TextField("", text: $store.unitText.sending(\.setUnitText))
                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 18.0))
                    .foregroundStyle(Colors.grey100.swiftUIColor)
                    .frame(width: 48, height: 48)
                    .roundedBorder(radius: 8.0, color: Colors.grey40)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                Spacer()
                Button {
                    store.send(.setCompleted)
                } label: {
                    if store.hasStart {
                        store.model.isCompleted ? Images.icCheckBox.swiftUIImage : Images.icCheckEmpty.swiftUIImage
                    }
                }
                .frame(width: 48, height: 48)
                .background(Colors.grey20.swiftUIColor)
                .clipShape(.rect(cornerRadius: 8.0))
                .roundedBorder(radius: 8.0, color: Colors.grey40)
                .disabled(!store.hasStart)
            }
        }
    }
}

#Preview {
    WodSetView(store: Store(initialState: WodSetFeature.State(hasStart: true, isOrderSetVisible: true, model: WodSetModel.fake), reducer: {
        WodSetFeature()
    }))
}
