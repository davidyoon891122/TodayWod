//
//  Programs+Entity.swift
//  TodayWod
//
//  Created by 오지연 on 9/28/24.
//

import Foundation

/**
 - Program : 일주일치 DayWorkOut 묶음.
 - DayWorkOut : 하루에 배당되는 Wod 묶음.
 - WorkOut : WarmUp, Main, CoolDown으로 구분되는 Wod 묶음.
 - Wod : 운동 낱개 하나의 정보.
 - WodSet : User Custom 가능한 Wod 하위의 운동 낱개 배열의 정보.
 */
struct ProgramEntity: Codable, Equatable {
    
    let methodType: ProgramMethodType
    let level: LevelType
    let dayWorkouts: [DayWorkoutEntity]
    
}

extension ProgramEntity {
    
    static var fake: Self = .init(methodType: .body, level: .beginner, dayWorkouts: DayWorkoutEntity.bodyBeginnerAlphaWeek)
    
}

struct DayWorkoutEntity: Codable, Equatable {
    
    let type: DayWorkoutTagType
    let title: String
    let subTitle: String
    let expectedMinute: Int
    let minExpectedCalorie: Int
    let maxExpectedCalorie: Int
    var workouts: [WorkoutEntity]
    
}

extension DayWorkoutEntity {
    
    static var fake: Self = .init(type: .start, title: "알파 데이", subTitle: "한주를 시작하는", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerAlphaDay1Info)

}

struct WorkoutEntity: Codable, Equatable {
    
    let type: WorkoutType
    var wods: [WodEntity]
    
}

struct WodEntity: Codable, Equatable {
    
    let title: String
    let subTitle: String
    let unit: ExerciseUnit
    let unitValue: Int
    let set: Int?
    let wodSets: [WodSetEntity]?
    
    init(title: String, subTitle: String, unit: ExerciseUnit, unitValue: Int, set: Int = 1, wodSets: [WodSetEntity]) {
        self.title = title
        self.subTitle = subTitle
        self.unit = unit
        self.unitValue = unitValue
        self.set = set
        self.wodSets = wodSets
    }
    
}

extension WodEntity {
    
    static var fake: Self {
        .init(title: "덤밸 스내치", subTitle: "lowing abc", unit: .repetitions, unitValue: 8, set: 3, wodSets: WodSetEntity.fakes)
    }

}

struct WodSetEntity: Codable, Equatable {
    
    let order: Int
    let unitValue: Int
    let isCompleted: Bool
    
}

extension WodSetEntity {
    
    static var fake: Self {
        .init(order: 0, unitValue: 15, isCompleted: false)
    }
    
    static var fakes: [Self] = [
        .init(order: 0, unitValue: 5, isCompleted: false),
        .init(order: 1, unitValue: 5, isCompleted: false)
    ]
    
}
