//
//  WorkoutModel.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

struct WorkoutModel: Codable, Equatable, Identifiable {
    
    var id: UUID
    
    let type: WorkoutType
    var wods: [WodModel]
    
    init(data: WorkoutEntity) {
        let id = UUID()
        self.id = id
        
        self.type = data.type
        self.wods = data.wods.map { WodModel(workoutId: id, data: $0) }
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
    
    var completedSetCount: Int {
        self.wods.reduce(0) { $0 + $1.completedSetCount }
    }
    
}

struct WodModel: Codable, Equatable, Identifiable {
    
    var id: UUID
    var workoutId: UUID
    
    let title: String
    let subTitle: String
    let unit: ExerciseUnit
    let unitValue: Int
    let set: Int
    var wodSets: [WodSetModel] = []
    
    init(workoutId: UUID, data: WodEntity) {
        self.id = UUID()
        self.workoutId = workoutId
        
        self.title = data.title
        self.subTitle = data.subTitle
        self.unit = data.unit
        self.unitValue = data.unitValue
        self.set = data.set
        self.wodSets = data.wodSets.map { WodSetModel(workoutId: workoutId, wodModelId: id, data: $0) }
    }
    
    init(coreData: WodCoreEntity) {
        self.id = coreData.id
        self.workoutId = coreData.workoutId
        self.title = coreData.title
        self.subTitle = coreData.subTitle
        self.unit = ExerciseUnit(rawValue: coreData.unit) ?? .seconds
        self.unitValue = Int(coreData.unitValue)
        self.set = Int(coreData.set)
        self.wodSets = coreData.wodSets
            .compactMap { $0 as? WodSetCoreEntity }
            .map { WodSetModel(coreData: $0) }
    }
    
}

extension WodModel {
    
    var completedSetCount: Int {
        self.wodSets.count(where: { $0.isCompleted })
    }
    
    var isSetVisible: Bool {
        self.set > 1
    }
    
    var displaySet: String {
        "세트 (Set)"
    }
    
    var displayCompletedSet: String {
        if self.set > 1 {
            return "\(self.set) 세트"
        } else {
            if let set = wodSets.first {
                return set.displayUnitValue + self.unit.title
            }
            return "1 세트"
        }
    }
    
}

extension WodModel {
    
    static let fake: Self = .init(workoutId: UUID(), data: WodEntity.fake)
    
}
