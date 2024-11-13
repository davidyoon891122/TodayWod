//
//  WorkoutModel.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

struct WorkoutModel: Codable, Equatable, Identifiable {
    
    var id: String
    let type: WorkoutType
    var wods: [WodModel]
    
    init(data: WorkoutEntity) {
        self.id = data.id
        self.type = data.type
        self.wods = data.wods.map { WodModel(data: $0) }
    }
    
    init(coreData: WorkoutCoreEntity) {
        self.id = coreData.id
        self.type = WorkoutType(rawValue: coreData.type) ?? .coolDown
        self.wods = coreData.wods
            .compactMap { $0 as? WodCoreEntity }
            .map { WodModel(coreData: $0) }
    }
    
}

extension WorkoutModel {
    
    var isCompleted: Bool {
        self.wods.allSatisfy { $0.isCompleted }
    }
    
    var isContainCompleted: Bool {
        self.wods.contains { $0.isContainCompleted }
    }
    
    var hasCompletedWods: Bool {
        self.completedWodsCount > 0
    }
    
    var completedWodsCount: Int {
        self.wods.reduce(0) { $0 + ($1.isContainCompleted ? 1 : 0) }
    }
    
    var completedWods: [WodModel] { // 세트 중 하나라도 성공 시 Record에 노출. (기획)
        self.wods.filter { $0.isContainCompleted }
    }
    
}

extension WorkoutModel {
    
    static let fake: Self = .init(data: WorkoutEntity.fake)
    
}
