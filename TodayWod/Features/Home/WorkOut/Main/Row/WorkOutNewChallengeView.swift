//
//  WorkOutNewChallengeView.swift
//  TodayWod
//
//  Created by 오지연 on 9/29/24.
//

import SwiftUI
import ComposableArchitecture

struct WorkOutNewChallengeView: View {
    
    @Perception.Bindable var store: StoreOf<WorkOutFeature>
    
    var body: some View {
        HStack(spacing: 8) {
            Images.icAdd24.swiftUIImage
                .frame(width: 40, height: 40)
            VStack(alignment: .leading, spacing: 4) {
                Text(Constants.title)
                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 16))
                    .foregroundStyle(Colors.grey100.swiftUIColor)
                Text(Constants.subTitle)
                    .font(Fonts.Pretendard.regular.swiftUIFont(size: 13))
                    .foregroundStyle(Colors.grey80.swiftUIColor)
                
            }
            .padding(.vertical, 20)
            Spacer()
        }
        .onTapGesture {
            store.send(.didTapNewChallengeButton)
        }
        .background(Colors.grey10.swiftUIColor)
        .cornerRadius(12, corners: .allCorners)
        .padding(.horizontal, 16)
        .padding(.top, 48)
    }
    
}

extension WorkOutNewChallengeView {
    
    enum Constants {
        static let title: String = "새로운 도전하기"
        static let subTitle: String = "한주 간 운동 루틴을 새롭게 만들어요"
    }
    
}

#Preview {
    WorkOutNewChallengeView(store: Store(initialState: WorkOutFeature.State()) {
        WorkOutFeature()
    })
}
