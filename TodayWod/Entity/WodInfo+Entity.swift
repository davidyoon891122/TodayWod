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
    
    static var fake: Self = .init(methodType: .body, level: .beginner, workOutDays: WorkOutDayEntity.fakes)
    
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
    
    static var fake: Self {
        .init(type: .start, title: "알파 데이", subTitle: "한주를 시작하는", expectedMinute: 60, estimatedStartCalorie: 400, estimatedEndCalorie: 500, workOuts: WorkOutInfoEntity.infoDummies)
    }
    
    static var fakes: [Self] = [
        .init(type: .start, title: "알파 데이", subTitle: "한주를 시작하는", expectedMinute: 60, estimatedStartCalorie: 400, estimatedEndCalorie: 500, workOuts: WorkOutInfoEntity.infoDummies),
        .init(type: .default, title: "타이탄 데이", subTitle: "한주를 시작하는", expectedMinute: 60, estimatedStartCalorie: 400, estimatedEndCalorie: 500, workOuts: WorkOutInfoEntity.infoDummies),
        .init(type: .end, title: "히어로 데이", subTitle: "한주를 시작하는", expectedMinute: 60, estimatedStartCalorie: 400, estimatedEndCalorie: 500, workOuts: WorkOutInfoEntity.infoDummies)
    ]
    
}

struct WorkOutInfoEntity: Codable, Equatable {
    
    let type: WorkOutType
    var items: [WodEntity]
    
}

extension WorkOutInfoEntity {
    
    static var infoDummies: [Self] = [
        .init(type: .WarmUp, items: WodEntity.warmUpDummies),
        .init(type: .Main, items: WodEntity.mainDummies),
        .init(type: .CoolDown, items: WodEntity.coolDownDummies)
    ]
    
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
    
    static var warmUpDummies: [Self] = [
        .init(title: "암서클", subTitle: "lowing abc",
              unit: .minutes, unitValue: 2),
        .init(title: "점핑잭", subTitle: "lowing abc", unit: .minutes, unitValue: 2)
    ]
    
    static var mainDummies: [Self] = [
        .init(title: "덤밸 스내치", subTitle: "lowing abc", unit: .repetitions, unitValue: 8, set: 3),
        .init(title: "핸드 릴리즈 푸시업", subTitle: "lowing abc", unit: .repetitions, unitValue: 10, set: 3),
        .init(title: "박스", subTitle: "lowing abc", unit: .repetitions, unitValue: 8, set: 3)
    ]
    
    static var coolDownDummies: [Self] = [
        .init(title: "플랭크", subTitle: "lowing abc", unit: .minutes, unitValue: 1),
        .init(title: "스트레칭", subTitle: "lowing abc", unit: .minutes, unitValue: 3)
    ]
    
}
