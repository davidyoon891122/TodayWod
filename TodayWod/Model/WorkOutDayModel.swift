//
//  WorkOutMoel.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

struct WodInfo: Codable, Equatable, Identifiable {

    var id: UUID
    
    var workOutDays: [WorkOutDayModel]
    
    init(data: WodInfoEntity) {
        self.id = UUID()
        self.workOutDays = data.workOutDays.map { WorkOutDayModel(data: $0) }
    }
    
}

extension WodInfo {
    
    var hasWod: Bool {
        self.workOutDays.count != 0
    }
    
}

extension WodInfo {
    
    static let bodyBeginners: [Self] = WodInfoEntity.bodyBeginners.map { WodInfo(data: $0) }

}

struct WorkOutDayModel: Codable, Equatable, Identifiable {
    
    var id: UUID
    var completedInfo: CompletedWorkOutDayInfo
    
    let type: WorkOutDayTagType
    let title: String
    let subTitle: String
    let expectedMinute: Int
    let estimatedStartCalorie: Int
    let estimatedEndCalorie: Int
    var workOuts: [WorkOutInfo]
    
    init(data: WorkOutDayEntity) {
        self.id = UUID()
        self.completedInfo = .init()
        
        self.type = data.type
        self.title = data.title
        self.subTitle = data.subTitle
        self.expectedMinute = data.expectedMinute
        self.estimatedStartCalorie = data.estimatedStartCalorie
        self.estimatedEndCalorie = data.estimatedEndCalorie
        self.workOuts = data.workOuts.map { WorkOutInfo(data: $0) }
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
    
    static let fake: Self = .init(data: WorkOutDayEntity.fake)
    
    static var fakes: [Self] = {
        return WorkOutDayEntity.bodyBeginnerAlphaWeek.map { fake -> WorkOutDayModel in
            .init(data: fake)
        }
    }()
    
}

struct CompletedWorkOutDayInfo: Codable, Equatable {
    
    var isCompleted: Bool
    var completedDate: Date?
    var completedDuration: Int?
    
    init(isCompleted: Bool = false, completedDate: Date? = nil, completedDuration: Int? = nil) {
        self.isCompleted = isCompleted
        self.completedDate = completedDate
        self.completedDuration = completedDuration
    }
    
}
