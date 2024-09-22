//
//  WodModel.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

struct WorkOutInfo: Codable, Equatable, Identifiable {
    
    var id: UUID = UUID()
    
    let type: WorkOutType
    let items: [WodModel]
    
}

extension WorkOutInfo {
    
    static var infoDummies: [Self] = [
        .init(type: .WarmUp, items: WodModel.warmUpDummies),
        .init(type: .Main, items: WodModel.mainDummies),
        .init(type: .CoolDown, items: WodModel.coolDownDummies)
    ]
    
}

struct WodModel: Codable, Equatable, Identifiable {
    
    var id: UUID = UUID()
    
    let title: String
    let subTitle: String
    let unit: ExerciseUnit
    let set: [WodSet]
    
    init(title: String, subTitle: String, unit: ExerciseUnit, set: [WodSet]) {
        self.title = title
        self.subTitle = subTitle
        self.unit = unit
        self.set = set
    }
    
}

extension WodModel {
    
    var isSetVisible: Bool {
        self.set.count > 1
    }
    
    var displaySet: String {
        "세트 (Set)"
    }
    
}

extension WodModel {
    
    static var fake: Self {
        .init(title: "덤밸 스내치", subTitle: "lowing abc", unit: .repetitions, set: [WodSet(unitValue: 8), WodSet(unitValue: 8), WodSet(unitValue: 8)])
    }
    
    static var warmUpDummies: [Self] = [
        .init(title: "암서클", subTitle: "lowing abc", 
              unit: .minutes, set: [WodSet(unitValue: 2)]),
        .init(title: "점핑잭", subTitle: "lowing abc", unit: .minutes, set: [WodSet(unitValue: 2)])
    ]
    
    static var mainDummies: [Self] = [
        .init(title: "덤밸 스내치", subTitle: "lowing abc", unit: .repetitions, set: [WodSet(unitValue: 8), WodSet(unitValue: 8), WodSet(unitValue: 8)]),
        .init(title: "핸드 릴리즈 푸시업", subTitle: "lowing abc", unit: .repetitions, set: [WodSet(unitValue: 10), WodSet(unitValue: 10), WodSet(unitValue: 10)]),
        .init(title: "박스", subTitle: "lowing abc", unit: .repetitions, set: [WodSet(unitValue: 8), WodSet(unitValue: 8), WodSet(unitValue: 8)])
    ]
    
    static var coolDownDummies: [Self] = [
        .init(title: "플랭크", subTitle: "lowing abc", unit: .minutes, set: [WodSet(unitValue: 1)]),
        .init(title: "스트레칭", subTitle: "lowing abc", unit: .minutes, set: [WodSet(unitValue: 3)])
    ]
    
}

struct WodSet: Codable, Equatable, Identifiable {

    var id: UUID = UUID()
    
    var unitValue: Int
    var isCompleted: Bool = false
    
}

extension WodSet {
    
    var displayUnitValue: String {
        String(self.unitValue)
    }
    
}

extension WodSet {
    
    static var fake: Self {
        .init(unitValue: 2, isCompleted: true)
    }
    
}
