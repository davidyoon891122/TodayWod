//
//  WodModel.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

struct WorkOutInfo: Codable, Equatable {
    
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

struct WodModel: Codable, Equatable {
    
    let name: String
    let unit: ExerciseUnit
    let set: Int
    let minute: Int?
    let count: Int?
    
    init(name: String, unit: ExerciseUnit, set: Int, minute: Int? = nil, count: Int? = nil) {
        self.name = name
        self.unit = unit
        self.set = set
        self.minute = minute
        self.count = count
    }
    
}

extension WodModel {
    
    static var warmUpDummies: [Self] = [
        .init(name: "암서클", unit: .minutes, set: 1, minute: 2),
        .init(name: "점핑잭", unit: .minutes, set: 1, minute: 2)
    ]
    
    static var mainDummies: [Self] = [
        .init(name: "덤밸 스내치", unit: .repetitions, set: 3, count: 8),
        .init(name: "핸드 릴리즈 푸시업", unit: .repetitions, set: 3, count: 10),
        .init(name: "박스", unit: .repetitions, set: 3, count: 8)
    ]
    
    static var coolDownDummies: [Self] = [
        .init(name: "플랭크", unit: .minutes, set: 1, minute: 1),
        .init(name: "스트레칭", unit: .minutes, set: 1, minute: 3)
    ]
    
}
