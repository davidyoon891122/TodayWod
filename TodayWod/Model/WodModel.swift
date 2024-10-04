//
//  WodModel.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

struct WorkOutInfo: Codable, Equatable, Identifiable {
    
    var id: UUID
    
    let type: WorkOutType
    var items: [WodModel]
    
    init(data: WorkOutInfoEntity) {
        let id = UUID()
        self.id = id
        
        self.type = data.type
        self.items = data.items.map { WodModel(data: $0).createParentClassification(id: id) }
    }
    
}

extension WorkOutInfo {
    
    var completedSetCount: Int {
        self.items.reduce(0) { $0 + $1.completedSetCount }
    }
    
}

struct WodModel: Codable, Equatable, Identifiable {
    
    var id: UUID
    var workOutInfoId: UUID?
    
    let title: String
    let subTitle: String
    let unit: ExerciseUnit
    var wodSet: [WodSet]
    let set: Int
    
    init(data: WodEntity) {
        self.id = UUID()
        self.workOutInfoId = nil
        
        self.title = data.title
        self.subTitle = data.subTitle
        self.unit = data.unit
        self.wodSet = WodSet(unitValue: data.unitValue).createNumbering(set: data.set, workOutInfoId: workOutInfoId, wodModelId: id)
        self.set = data.set
    }
    
}

extension WodModel {
    
    var completedSetCount: Int {
        self.wodSet.count(where: { $0.isCompleted })
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
            if let set = wodSet.first {
                return set.displayUnitValue + self.unit.title
            }
            return "1 세트"
        }
    }
    
}

extension WodModel {
    
    func createParentClassification(id: UUID) -> Self {
        var updatedWod = self
        updatedWod.workOutInfoId = id
        return updatedWod
    }
    
}

extension WodModel {
    
    static let fake: Self = .init(data: WodEntity.fake)
    
}
