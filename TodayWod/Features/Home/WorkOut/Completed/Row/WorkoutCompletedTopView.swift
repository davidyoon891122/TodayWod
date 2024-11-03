//
//  WorkoutCompletedTopView.swift
//  TodayWod
//
//  Created by D프로젝트노드_오지연 on 10/4/24.
//
import SwiftUI

struct WorkoutCompletedTopView: View {
    
    let item: DayWorkoutModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(item.duration.timerFormatter)
                .font(Fonts.Pretendard.bold.swiftUIFont(size: 40))
                .foregroundStyle(.grey100)
            Text(Constants.totalDuration)
                .font(Fonts.Pretendard.regular.swiftUIFont(size: 13))
                .foregroundStyle(.grey80)
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.displayEstimatedCalorie)
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 18))
                        .foregroundStyle(.grey100)
                    Text(item.displayEstimatedCalorieTitle)
                        .font(Fonts.Pretendard.regular.swiftUIFont(size: 13))
                        .foregroundStyle(.grey80)
                }
                .padding(.trailing, 40)
            
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(item.completedWodsCount)")
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

private extension WorkoutCompletedTopView {
    
    enum Constants {
        static let totalDuration = "운동 시간"
        static let workoutTitle = "진행한 운동"
    }
    
}

#Preview {
    VStack {
        WorkoutCompletedTopView(item: .completedFake)
    }
    .padding(20)
    .background(Colors.blue10.swiftUIColor)
}
