//
//  RecentDayWorkOut+Entity.swift
//  TodayWod
//
//  Created by 오지연 on 10/13/24.
//
import Foundation

struct RecentDayWorkoutEntity: Codable, Equatable {
    
    var date: Date?
    var duration: Int
    let type: DayWorkoutTagType
    let title: String
    let subTitle: String
    let expectedMinute: Int
    let minExpectedCalorie: Int
    let maxExpectedCalorie: Int
    var workouts: [WorkoutEntity]
    
}

extension RecentDayWorkoutEntity {
    
    static var fakes: [Self] = [
        .init(date: "2024-09-30".toDate(), duration: 120, type: .start, title: "알파 데이", subTitle: "한주를 시작하는", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerAlphaDay1Info),
        .init(date: "2024-10-02".toDate(), duration: 120, type: .end, title: "히어로 데이", subTitle: "열정적인", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerAlphaDay2Info)
    ]

}
