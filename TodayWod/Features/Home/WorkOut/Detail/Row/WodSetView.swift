//
//  WodSetView.swift
//  TodayWod
//
//  Created by 오지연 on 9/22/24.
//

import SwiftUI
import ComposableArchitecture

struct WodSetView: View {
    
    @Perception.Bindable var store: StoreOf<WorkOutDetailFeature>
    let model: WodSet
    
    @State private var unitText: String = ""
    
    init(store: StoreOf<WorkOutDetailFeature>, model: WodSet) {
        self.store = store
        self.model = model
        
        self._unitText = State(initialValue: model.displayUnitValue)
    }
    
    var body: some View {
        HStack {
            TextField("", text: $unitText)
                .font(Fonts.Pretendard.bold.swiftUIFont(size: 18))
                .foregroundStyle(Colors.grey100.swiftUIColor)
                .frame(width: 48, height: 48)
                .roundedBorder(radius: 8, color: Colors.grey40)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            Spacer()
            Button {
                store.send(.setCompleted(model))
            } label: {
                model.isCompleted ? Images.icCheckBox.swiftUIImage : Images.icCheckEmpty.swiftUIImage
            }
            .frame(width: 48, height: 48)
        }
        .onChange(of: unitText) { text in
            store.send(.setUnitText(text, model))
        }
    }
    
}

#Preview {
    WodSetView(store: Store(initialState: WorkOutDetailFeature.State(item: WorkOutDayModel.fake), reducer: {
        WorkOutDetailFeature()
    }), model: WodSet.fake)
}
