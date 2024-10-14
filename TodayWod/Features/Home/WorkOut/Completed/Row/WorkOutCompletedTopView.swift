//
//  WorkOutCompletedTopView.swift
//  TodayWod
//
//  Created by D프로젝트노드_오지연 on 10/4/24.
//
import SwiftUI

struct WorkOutCompletedTopView: View {
    
    let item: DayWorkOutModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(item.duration.timerFormatter)
                .font(Fonts.Pretendard.bold.swiftUIFont(size: 40))
                .foregroundStyle(.grey100)
            Text(Constants.totalDuration)
                .font(Fonts.Pretendard.regular.swiftUIFont(size: 13))
                .foregroundStyle(.grey80)
            HStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.displayEstimatedCalorie)
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 18))
                        .foregroundStyle(.grey100)
                    Text(Constants.totalKcal)
                        .font(Fonts.Pretendard.regular.swiftUIFont(size: 13))
                        .foregroundStyle(.grey80)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(item.completedSetCount)")
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 18))
                        .foregroundStyle(.grey100)
                    Text(Constants.workoutTitle)
                        .font(Fonts.Pretendard.regular.swiftUIFont(size: 13))
                        .foregroundStyle(.grey80)
                }
                Spacer()
            }
            .padding(.top, 40.0)
        }
        .padding(30.0)
        .background(.white)
        .cornerRadius(12.0, corners: .allCorners)
    }
    
}

private extension WorkOutCompletedTopView {
    
    enum Constants {
        static let totalDuration = "운동 시간"
        static let totalKcal = "소모 Kcal"
        static let workoutTitle = "진행한 운동"
    }
    
}

#Preview {
    VStack {
        WorkOutCompletedTopView(item: .completedFake)
    }
    .padding(20)
    .background(Colors.blue10.swiftUIColor)
}
