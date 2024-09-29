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
                    Images.icRefreshGray16.swiftUIImage
                    Text(Constants.title)
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 13))
                        .foregroundStyle(Colors.grey60.swiftUIColor)
                }
            }
            .frame(width: 86, height: 38)
            .roundedBorder(radius: 4.0, color: Colors.grey40)
        }
        .frame(height: 54)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    
}

extension WorkOutTitleView {
    
    enum Constants {
        static let title: String = "초기화"
    }
    
}
