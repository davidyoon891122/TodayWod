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
    @Binding var model: WodSetModel
    
    @State private var unitText: String = ""
    
    var body: some View {
        WithPerceptionTracking {
            HStack(spacing: 10) {
                Text(self.model.displaySetNumber)
                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 18))
                    .foregroundStyle(Colors.grey100.swiftUIColor)
                    .frame(width: 48)
                TextField("", text: $unitText)
                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 18.0))
                    .foregroundStyle(Colors.grey100.swiftUIColor)
                    .frame(width: 48, height: 48)
                    .roundedBorder(radius: 8.0, color: Colors.grey40)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                Spacer()
                Button {
                    self.model.isCompleted.toggle()
                } label: {
                    if self.store.hasStart {
                        self.model.isCompleted ? Images.icCheckBox.swiftUIImage : Images.icCheckEmpty.swiftUIImage
                    }
                }
                .frame(width: 48, height: 48)
                .background(Colors.grey20.swiftUIColor)
                .clipShape(.rect(cornerRadius: 8.0))
                .roundedBorder(radius: 8.0, color: Colors.grey40)
                .disabled(!self.store.hasStart)
            }
            .onAppear {
                self.unitText = self.model.displayUnitValue
            }
            .onChange(of: unitText) { text in
                self.model.unitValue = text.toInt
            }
        }
    }
}

#Preview {
    WodSetView(store: Store(initialState: WorkOutDetailFeature.State(item: DayWorkoutModel.fake), reducer: {
        WorkOutDetailFeature()
    }), model: .constant(WodSetModel.fake))
}
