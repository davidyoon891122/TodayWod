//
//  WorkOutMoel.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

struct WodInfo: Codable, Equatable {
    
    let programType: MethodType
    let level: LevelType
    let workOutDays: [WorkOutDayModel]
    
}

extension WodInfo {
    
    static var fake: Self = .init(programType: .body, level: .beginner, workOutDays: WorkOutDayModel.fakes)
    
}

struct WorkOutDayModel: Codable, Equatable {
    
    let id: UUID = UUID()
    
    let type: WorkOutDayTagType
    let title: String
    let subTitle: String
    let expectedMinute: Int
    let estimatedStartCalorie: Int
    let estimatedEndCalorie: Int
    let workOuts: [WorkOutInfo]
    
}

extension WorkOutDayModel {
    
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

extension WorkOutDayModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
    
}
