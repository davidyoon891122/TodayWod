//
//  WodInfo+Entity.swift
//  TodayWod
//
//  Created by 오지연 on 9/28/24.
//

import Foundation

struct WodInfoEntityOrigin: Codable, Equatable {
    
    let methodType: ProgramMethodType
    let level: LevelType
    let workOutDays: [WorkOutDayEntityOrigin]
    
}

extension WodInfoEntityOrigin {
    
    static var fake: Self = .init(methodType: .body, level: .beginner, workOutDays: WorkOutDayEntityOrigin.bodyBeginnerAlphaWeek)
    
}

struct WorkOutDayEntityOrigin: Codable, Equatable {
    
    let type: WorkOutDayTagType
    let title: String
    let subTitle: String
    let expectedMinute: Int
    let estimatedMinCalorie: Int
    let estimatedMaxCalorie: Int
    var workOuts: [WorkOutInfoEntityOrigin]
    
}

extension WorkOutDayEntityOrigin {
    
    static var fake: Self = .init(type: .start, title: "알파 데이", subTitle: "한주를 시작하는", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerAlphaDay1Info)

}

struct WorkOutInfoEntityOrigin: Codable, Equatable {
    
    let type: WorkOutType
    var items: [WodEntityOrigin]
    
}

struct WodEntityOrigin: Codable, Equatable {
    
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

extension WodEntityOrigin {
    
    static var fake: Self {
        .init(title: "덤밸 스내치", subTitle: "lowing abc", unit: .repetitions, unitValue: 8, set: 3)
    }

}
