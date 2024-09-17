//
//  WodModel.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

struct WorkOutInfo {
    
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

struct WodModel {
    
    let name: String
    let type: WodType
    let set: Int
    let minute: Int? = nil
    let count: Int? = nil
    
}

extension WodModel {
    
    static var warmUpDummies: [Self] = [
        .init(name: "암서클", type: .분, set: 1, minute: 2),
        .init(name: "점핑잭", type: .분, set: 1, minute: 2)
    ]
    
    static var mainDummies: [Self] = [
        .init(name: "덤밸 스내치", type: .횟수, set: 3, count: 8),
        .init(name: "핸드 릴리즈 푸시업", type: .횟수, set: 3, count: 10),
        .init(name: "박스", type: .횟수, set: 3, count: 8)
    ]
    
    static var coolDownDummies: [Self] = [
        .init(name: "플랭크", type: .분, set: 1, minute: 1),
        .init(name: "스트레칭", type: .분, set: 1, minute: 3)
    ]
    
}
