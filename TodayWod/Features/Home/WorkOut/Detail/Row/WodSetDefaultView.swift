//
//  WodSetDefaultView.swift
//  TodayWod
//
//  Created by D프로젝트노드_오지연 on 10/17/24.
//

import SwiftUI
import ComposableArchitecture

struct WodSetDefaultView: View {
    
    @Perception.Bindable var store: StoreOf<WorkOutDetailFeature>
    @Binding var model: WodSetModel
    
    @State private var unitText: String = ""
    
    var body: some View {
        WithPerceptionTracking {
            HStack {
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
                    // TODO: - 모델을 뷰에서 직접 변경하여, Action에서 상태 파악 불가
                    if self.model.isCompleted {
                        store.send(.resetTimer)
                    }
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
    WodSetDefaultView(store: Store(initialState: WorkOutDetailFeature.State(item: DayWorkoutModel.fake), reducer: {
        WorkOutDetailFeature()
    }), model: .constant(WodSetModel.fake))
}
