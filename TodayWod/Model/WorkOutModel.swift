//
//  WorkOutModel.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

struct WorkOutModel: Codable, Equatable, Identifiable {
    
    var id: UUID
    
    let type: WorkOutType
    var wods: [WodModel]
    
    init(data: WorkOutEntity) {
        let id = UUID()
        self.id = id
        
        self.type = data.type
        self.wods = data.wods.map { WodModel(workOutId: id, data: $0) }
    }
    
}

extension WorkOutModel {
    
    var completedSetCount: Int {
        self.wods.reduce(0) { $0 + $1.completedSetCount }
    }
    
}

struct WodModel: Codable, Equatable, Identifiable {
    
    var id: UUID
    var workOutId: UUID
    
    let title: String
    let subTitle: String
    let unit: ExerciseUnit
    let unitValue: Int
    let set: Int
    var wodSets: [WodSet] = []// TODO: wodSets
    
    init(workOutId: UUID, data: WodEntity) {
        self.id = UUID()
        self.workOutId = workOutId
        
        self.title = data.title
        self.subTitle = data.subTitle
        self.unit = data.unit
        self.unitValue = data.unitValue
        self.set = data.set
        self.wodSets = data.wodSets.map { WodSet(workOutId: workOutId, wodModelId: id, data: $0) }
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
    
    static let fake: Self = .init(workOutId: UUID(), data: WodEntity.fake)
    
}
