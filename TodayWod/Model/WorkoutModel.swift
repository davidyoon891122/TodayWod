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

struct WodModel: Codable, Equatable, Identifiable {
    
    var id: UUID
    
    let title: String
    let subTitle: String
    let unit: ExerciseUnit
    let unitValue: Int
    let set: Int
    var wodSets: [WodSetModel] = []
    let expectedCalorie: Int

    init(data: WodEntity) {
        self.id = UUID()
        
        self.title = data.title
        self.subTitle = data.subTitle
        self.unit = data.unit
        self.unitValue = data.unitValue
        self.set = data.set ?? 1
        self.wodSets = data.wodSets?.map { WodSetModel(data: $0) } ?? [WodSetModel(unitValue: data.unitValue)]
        self.expectedCalorie = data.expectedCalorie
    }
    
    init(coreData: WodCoreEntity) {
        self.id = coreData.id
        self.title = coreData.title
        self.subTitle = coreData.subTitle
        self.unit = ExerciseUnit(rawValue: coreData.unit) ?? .seconds
        self.unitValue = Int(coreData.unitValue)
        self.set = Int(coreData.set)
        self.wodSets = coreData.wodSets
            .compactMap { $0 as? WodSetCoreEntity }
            .map { WodSetModel(coreData: $0) }
        self.expectedCalorie = Int(coreData.expectedCalorie)
    }
    
}

extension WodModel {
    
    var newWodSet: WodSetModel {
        .init(unitValue: unitValue, order: self.wodSets.count+1)
    }
    
    var isCompleted: Bool {
        self.wodSets.allSatisfy { $0.isCompleted }
    }
    
    var isContainCompleted: Bool {
        self.wodSets.contains { $0.isCompleted }
    }
    
    var isOrderSetVisible: Bool {
        self.set > 1
    }
    
    var canRemoveSet: Bool {
        self.wodSets.count > 1
    }
    
    var displaySet: String {
        "세트 (Set)"
    }
    
    var displayCompletedSet: String {
        if self.set > 1 {
            let completedSetCount = wodSets.count { $0.isCompleted }
            return "\(completedSetCount) 세트"
        } else {
            if let set = wodSets.first {
                return set.displayUnitValue + self.unit.title
            }
            return "1 세트"
        }
    }
    
}

extension WodModel {
    
    static let fake: Self = .init(data: WodEntity.fake)
    
}
