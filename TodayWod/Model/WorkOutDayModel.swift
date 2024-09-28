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
    
    init(methodType: ProgramMethodType, level: LevelType, workOutDays: [WorkOutDayModel]) {
        self.methodType = methodType
        self.level = level
        self.workOutDays = workOutDays
    }
    
}

extension WodInfo {
    
    static var fake: Self = .init(methodType: .body, level: .beginner, workOutDays: WorkOutDayModel.fakes)
    
}

struct WorkOutDayModel: Codable, Equatable, Identifiable {
    
    var id: UUID = UUID()
    var completedInfo: CompletedWorkOutDayInfo = .init()
    
    let type: WorkOutDayTagType
    let title: String
    let subTitle: String
    let expectedMinute: Int
    let estimatedStartCalorie: Int
    let estimatedEndCalorie: Int
    var workOuts: [WorkOutInfo]
    
    init(type: WorkOutDayTagType, title: String, subTitle: String, expectedMinute: Int, estimatedStartCalorie: Int, estimatedEndCalorie: Int, workOuts: [WorkOutInfo]) {
        self.type = type
        self.title = title
        self.subTitle = subTitle
        self.expectedMinute = expectedMinute
        self.estimatedStartCalorie = estimatedStartCalorie
        self.estimatedEndCalorie = estimatedEndCalorie
        self.workOuts = workOuts
    }
    
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

struct CompletedWorkOutDayInfo: Codable, Equatable { // TODO: - Refactoring 구조. 이 구조는 내부에서 mapping한 값만 갖도록.
    
    var isCompleted: Bool
    var completedDate: Date?
    var completedDuration: Int?
    
    init(isCompleted: Bool = false, completedDate: Date? = nil, completedDuration: Int? = nil) {
        self.isCompleted = isCompleted
        self.completedDate = completedDate
        self.completedDuration = completedDuration
    }
    
}
