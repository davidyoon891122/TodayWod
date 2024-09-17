//
//  WorkOutMoel.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

struct WodInfo {
    
    let programType: MethodType
    let level: LevelType
    let workOutDays: [WorkOutDayModel]
    
}

extension WodInfo {
    
    static var fake: Self = {
        .init(programType: .body, level: .beginner, workOutDays: WorkOutDayModel.fake)
    }
    
}

struct WorkOutDayModel {
    
    let type: WorkOutDayTagType
    let title: String
    let subTitle: String
    let expectedMinute: Int
    let estimatedStartCalorie: Int
    let estimatedEndCalorie: Int
    let workOuts: [WorkOutInfo]
    
}

extension WorkOutDayModel {
    
    static var fake: Self {
        .init(type: .start, title: "알파 데이", subTitle: "한주를 시작하는", expectedMinute: 60, estimatedStartCalorie: 400, estimatedEndCalorie: 500, workOuts: WorkOutInfo.infoDummies)
    }
    
}
