//
//  WorkoutCompletedProgramView.swift
//  TodayWod
//
//  Created by 오지연 on 10/4/24.
//
import SwiftUI

struct WorkoutCompletedProgramView: View {
    
    let item: DayWorkoutModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(item.workouts) { workout in
                if workout.hasCompletedWods {
                    Text(workout.type.title)
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 16))
                        .foregroundStyle(Colors.grey100.swiftUIColor)
                        .frame(height: 24.0)
                        .padding(.top, 10.0)
                    
                    LazyVStack(alignment: .leading) {
                        ForEach(workout.completedWods) { item in
                            HStack {
                                Text(item.title)
                                    .font(Fonts.Pretendard.regular.swiftUIFont(size: 16))
                                    .foregroundStyle(Colors.grey100.swiftUIColor)
                                Spacer()
                                Text(item.displayCompletedSet)
                                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 16))
                                    .foregroundStyle(Colors.grey100.swiftUIColor)
                            }
                            .padding(16.0)
                            .background(.white)
                            .cornerRadius(12.0)
                        }
                    }
                }
            }
        }
    }
    
}

#Preview {
    VStack {
        WorkoutCompletedProgramView(item: .completedFake)
    }
    .padding(20)
    .background(Colors.blue10.swiftUIColor)
}
