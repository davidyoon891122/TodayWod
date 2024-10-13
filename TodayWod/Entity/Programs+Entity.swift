//
//  Programs+Entity.swift
//  TodayWod
//
//  Created by 오지연 on 9/28/24.
//

import Foundation

struct ProgramEntity: Codable, Equatable {
    
    let methodType: ProgramMethodType
    let level: LevelType
    let weeklyWorkOuts: [DayWorkOutEntity]
    
}

extension ProgramEntity {
    
    static var fake: Self = .init(methodType: .body, level: .beginner, weeklyWorkOuts: DayWorkOutEntity.bodyBeginnerAlphaWeek)
    
}

struct DayWorkOutEntity: Codable, Equatable {
    
    let type: DayWorkOutTagType
    let title: String
    let subTitle: String
    let expectedMinute: Int
    let minEstimatedCalorie: Int
    let maxEstimatedCalorie: Int
    var dayWorkOuts: [WorkOutEntity]
    
}

extension DayWorkOutEntity {
    
    static var fake: Self = .init(type: .start, title: "알파 데이", subTitle: "한주를 시작하는", expectedMinute: 60, minEstimatedCalorie: 400, maxEstimatedCalorie: 500, dayWorkOuts: WorkOutEntity.bodyBeginnerAlphaDay1Info)

}

struct WorkOutEntity: Codable, Equatable {
    
    let type: WorkOutType
    var wods: [WodEntity]
    
}

struct WodEntity: Codable, Equatable {
    
    let title: String
    let subTitle: String
    let unit: ExerciseUnit
    let unitValue: Int
    let set: Int
    let wodSets: [WodSetEntity]
    
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
