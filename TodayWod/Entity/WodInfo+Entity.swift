//
//  WodInfo+Entity.swift
//  TodayWod
//
//  Created by 오지연 on 9/28/24.
//

import Foundation

struct WodInfoEntity: Codable, Equatable {
    
    let methodType: ProgramMethodType
    let level: LevelType
    let workOutDays: [WorkOutDayEntity]
    
}

extension WodInfoEntity {
    
    static var fake: Self = .init(methodType: .body, level: .beginner, workOutDays: WorkOutDayEntity.bodyBeginnerAlphaWeek)
    
}

struct WorkOutDayEntity: Codable, Equatable {
    
    let type: WorkOutDayTagType
    let title: String
    let subTitle: String
    let expectedMinute: Int
    let estimatedStartCalorie: Int
    let estimatedEndCalorie: Int
    var workOuts: [WorkOutInfoEntity]
    
}

extension WorkOutDayEntity {
    
    static var fake: Self = .init(type: .start, title: "알파 데이", subTitle: "한주를 시작하는", expectedMinute: 60, estimatedStartCalorie: 400, estimatedEndCalorie: 500, workOuts: WorkOutInfoEntity.bodyBeginnerAlphaDay1Info)

}

struct WorkOutInfoEntity: Codable, Equatable {
    
    let type: WorkOutType
    var items: [WodEntity]
    
}

struct WodEntity: Codable, Equatable {
    
    let title: String
    let subTitle: String
    let unit: ExerciseUnit
    let unitValue: Int
    let set: Int
    
    init(title: String, subTitle: String, unit: ExerciseUnit, unitValue: Int, set: Int = 1) {
        self.title = title
        self.subTitle = subTitle
        self.unit = unit
        self.unitValue = unitValue
        self.set = set
    }
    
}

extension WodEntity {
    
    static var fake: Self {
        .init(title: "덤밸 스내치", subTitle: "lowing abc", unit: .repetitions, unitValue: 8, set: 3)
    }
    
}
