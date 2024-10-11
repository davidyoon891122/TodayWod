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
    
    init(data: WodInfoEntityOrigin) {
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
    
    static let bodyBeginners: [Self] = WodInfoEntityOrigin.bodyBeginners.map { WodInfo(data: $0) }

}

struct WorkOutDayModel: Codable, Equatable, Identifiable {
    
    var id: UUID
    var duration: Int
    var completedInfo: CompletedWorkOutDayInfo
    
    let type: WorkOutDayTagType
    let title: String
    let subTitle: String
    let expectedMinute: Int
    let estimatedMinCalorie: Int
    let estimatedMaxCalorie: Int
    var workOuts: [WorkOutInfo]
    
    init(data: WorkOutDayEntityOrigin) {
        self.id = UUID()
        self.duration = 0
        self.completedInfo = .init()
        
        self.type = data.type
        self.title = data.title
        self.subTitle = data.subTitle
        self.expectedMinute = data.expectedMinute
        self.estimatedMinCalorie = data.estimatedMinCalorie
        self.estimatedMaxCalorie = data.estimatedMaxCalorie
        self.workOuts = data.workOuts.map { WorkOutInfo(data: $0) }
    }
    
}

extension WorkOutDayModel {
    
    var isCompleted: Bool {
        self.completedInfo.isCompleted
    }
    
    var displayExpectedMinuteTitle: String {
        "예상 시간"
    }
    
    var displayEstimatedCalorieTitle: String {
        "예상 소모 Kcal"
    }
    
    var displayExpectedMinute: String {
        "약 \(expectedMinute)분"
    }
    
    var displayEstimatedCalorie: String {
        "약 \(estimatedMinCalorie)~\(estimatedMaxCalorie) Kcal"
    }
    
    var completedSetCount: Int {
        self.workOuts.reduce(0) { $0 + $1.completedSetCount }
    }
    
}

extension WorkOutDayModel {
    
    static let fake: Self = .init(data: WorkOutDayEntityOrigin.fake)
    
    static let completedFake: Self = {
        var item = WorkOutDayModel.fake
        item.completedInfo = .init(isCompleted: true, completedDate: Date())
        return item
    }()
    
    static var fakes: [Self] = {
        return WorkOutDayEntityOrigin.bodyBeginnerAlphaWeek.map { fake -> WorkOutDayModel in
            .init(data: fake)
        }
    }()
    
}

struct CompletedWorkOutDayInfo: Codable, Equatable {
    
    var isCompleted: Bool
    var completedDate: Date?
    
    init(isCompleted: Bool = false, completedDate: Date? = nil) {
        self.isCompleted = isCompleted
        self.completedDate = completedDate
    }
    
}
