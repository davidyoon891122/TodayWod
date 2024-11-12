//
//  ProgramModel.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

struct ProgramModel: Codable, Equatable, Identifiable {

    var id: String
    let methodType: ProgramMethodType
    let level: LevelType
    var dayWorkouts: [DayWorkoutModel]
    
    init(data: ProgramEntity) {
        self.id = data.id
        self.methodType = data.methodType
        self.level = data.level
        self.dayWorkouts = data.dayWorkouts.map { DayWorkoutModel(data: $0) }
    }
    
    init(coreData: ProgramCoreEntity) {
        self.id = coreData.id
        self.methodType = ProgramMethodType(rawValue: coreData.methodType) ?? .body
        self.level = LevelType(rawValue: coreData.level) ?? .beginner
        self.dayWorkouts = coreData.dayWorkouts
            .compactMap { $0 as? DayWorkoutCoreEntity}
            .map { DayWorkoutModel(coreData: $0) }
    }
    
}

extension ProgramModel {
    
    var hasOwnProgram: Bool {
        self.dayWorkouts.count != 0
    }
    
    var isEnabledReset: Bool {
        dayWorkouts.contains { $0.isCompleted }
    }
    
}

extension ProgramModel {
    
    static let bodyBeginner: Self = .init(data: ProgramEntity.bodyBeginner)
    
    static let bodyBeginners: [Self] = ProgramEntity.bodyBeginners.map { ProgramModel(data: $0) }

}
