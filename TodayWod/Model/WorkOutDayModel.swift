//
//  WorkOutMoel.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

struct WodInfo: Codable, Equatable {
    
    let methodType: ProgramMethodType
    let level: LevelType
    let workOutDays: [WorkOutDayModel]
    
}

extension WodInfo {
    
    static var fake: Self = .init(methodType: .body, level: .beginner, workOutDays: WorkOutDayModel.fakes)
    
}

struct WorkOutDayModel: Codable, Equatable, Identifiable {
    
    var id: UUID = UUID()
    
    let type: WorkOutDayTagType
    let title: String
    let subTitle: String
    let expectedMinute: Int
    let estimatedStartCalorie: Int
    let estimatedEndCalorie: Int
    let workOuts: [WorkOutInfo]
    
}

extension WorkOutDayModel {
    
    var displayExpectedMinuteTitle: String {
        "예상 시간"
    }
    
    var displayEstimatedCalorieTitle: String {
        "예상 소모 칼로리"
    }
    
    var displayExpectedMinute: String {
        "약 \(expectedMinute)분"
    }
    
    var displayEstimatedCalorie: String {
        "약 \(estimatedStartCalorie) ~ \(estimatedEndCalorie) 칼로리"
    }
    
}

extension WorkOutDayModel {
    
    static var fake: Self {
        .init(type: .start, title: "알파 데이", subTitle: "한주를 시작하는", expectedMinute: 60, estimatedStartCalorie: 400, estimatedEndCalorie: 500, workOuts: WorkOutInfo.infoDummies)
    }
    
    static var fakes: [Self] = [
        .init(type: .start, title: "알파 데이", subTitle: "한주를 시작하는", expectedMinute: 60, estimatedStartCalorie: 400, estimatedEndCalorie: 500, workOuts: WorkOutInfo.infoDummies),
        .init(type: .default, title: "타이탄 데이", subTitle: "한주를 시작하는", expectedMinute: 60, estimatedStartCalorie: 400, estimatedEndCalorie: 500, workOuts: WorkOutInfo.infoDummies),
        .init(type: .end, title: "히어로 데이", subTitle: "한주를 시작하는", expectedMinute: 60, estimatedStartCalorie: 400, estimatedEndCalorie: 500, workOuts: WorkOutInfo.infoDummies)
    ]
    
}
