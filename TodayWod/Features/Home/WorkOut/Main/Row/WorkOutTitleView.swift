//
//  WorkOutTitleView.swift
//  TodayWod
//
//  Created by 오지연 on 9/29/24.
//

import SwiftUI
import ComposableArchitecture

struct WorkOutTitleView: View {
    
    @Perception.Bindable var store: StoreOf<WorkOutFeature>
    
    var body: some View {
        HStack {
            Text(Constants.title)
                .font(Fonts.Pretendard.bold.swiftUIFont(size: 20))
                .foregroundStyle(Colors.grey100.swiftUIColor)
            Spacer()
            Button {
                store.send(.didTapResetButton)
            } label: {
                HStack {
                    store.isEnabledReset ? Images.icRefresh16.swiftUIImage : Images.icRefreshGray16.swiftUIImage
                    Text(Constants.resetTitle)
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 13))
                        .foregroundStyle(store.isEnabledReset ? Colors.grey100.swiftUIColor : Colors.grey60.swiftUIColor)
                }
            }
            .frame(width: 86, height: 38)
            .roundedBorder(radius: 4.0, color: Colors.grey40)
            .disabled(!store.isEnabledReset)
        }
        .frame(height: 54)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    
}

extension WorkOutTitleView {
    
    enum Constants {
        static let title: String = "한주 간 운동"
        static let resetTitle: String = "초기화"
    }
    
}

#Preview {
    WorkOutTitleView(store: Store(initialState: WorkOutFeature.State()) {
        WorkOutFeature()
    })
}
