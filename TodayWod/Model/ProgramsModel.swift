//
//  ProgramModel.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

struct ProgramModel: Codable, Equatable, Identifiable {

    var id: UUID
    
    var weeklyWorkOuts: [DayWorkOutModel]
    
    init(data: ProgramEntity) {
        self.id = UUID()
        self.weeklyWorkOuts = data.weeklyWorkOuts.map { DayWorkOutModel(data: $0) }
    }
    
}

extension ProgramModel {
    
    var hasOwnProgram: Bool {
        self.weeklyWorkOuts.count != 0
    }
    
}

extension ProgramModel {
    
    static let bodyBeginners: [Self] = ProgramEntity.bodyBeginners.map { ProgramModel(data: $0) }

}

struct DayWorkOutModel: Codable, Equatable, Identifiable {
    
    var id: UUID
    var date: Date? // 성공한 날짜.
    var duration: Int
    
    let type: DayWorkOutTagType
    let title: String
    let subTitle: String
    let expectedMinute: Int
    let minEstimatedCalorie: Int
    let maxEstimatedCalorie: Int
    var workOuts: [WorkOutModel]
    
    init(data: DayWorkOutEntity) {
        self.id = UUID()
        self.date = nil
        self.duration = 0
        
        self.type = data.type
        self.title = data.title
        self.subTitle = data.subTitle
        self.expectedMinute = data.expectedMinute
        self.minEstimatedCalorie = data.minEstimatedCalorie
        self.maxEstimatedCalorie = data.maxEstimatedCalorie
        self.workOuts = data.workOuts.map { WorkOutModel(data: $0) }
    }
    
}

extension DayWorkOutModel {
    
    var isCompleted: Bool {
        self.date != nil
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
        "약 \(minEstimatedCalorie)~\(maxEstimatedCalorie) Kcal"
    }
    
    var completedSetCount: Int {
        self.workOuts.reduce(0) { $0 + $1.completedSetCount }
    }
    
}

extension DayWorkOutModel {
    
    static let fake: Self = .init(data: DayWorkOutEntity.fake)
    
    static let completedFake: Self = {
        var item = DayWorkOutModel.fake
        item.date = Date()
        return item
    }()
    
    static var fakes: [Self] = {
        return DayWorkOutEntity.bodyBeginnerAlphaWeek.map { fake -> DayWorkOutModel in
            .init(data: fake)
        }
    }()
    
}
