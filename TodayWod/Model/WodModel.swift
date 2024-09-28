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
    
    var isSetVisible: Bool {
        self.set > 1
    }
    
    var displaySet: String {
        "세트 (Set)"
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
