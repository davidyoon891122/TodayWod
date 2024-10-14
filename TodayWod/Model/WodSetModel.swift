//
//  WodSetModel.swift
//  TodayWod
//
//  Created by D프로젝트노드_오지연 on 9/24/24.
//

import Foundation

struct WodSetModel: Codable, Equatable, Identifiable {

    var id: UUID
    var workoutId: UUID
    var wodModelId: UUID
    
    let order: Int
    var unitValue: Int
    var isCompleted: Bool
    
    init(workoutId: UUID, wodModelId: UUID, data: WodSetEntity) {
        self.id = UUID()
        self.workoutId = workoutId
        self.wodModelId = wodModelId
        
        self.order = data.order
        self.unitValue = data.unitValue
        self.isCompleted = data.isCompleted
    }
    
    init(coreData: WodSetCoreEntity) {
        self.id = coreData.id
        self.workoutId = coreData.workoutId
        self.wodModelId = coreData.wodModelId
        
        self.order = Int(coreData.order)
        self.unitValue = Int(coreData.unitValue)
        self.isCompleted = coreData.isCompleted
    }
    
}

extension WodSetModel {
    
    var displaySetNumber: String {
        String(self.order + 1)
    }
    
    var displayUnitValue: String {
        String(self.unitValue)
    }
    
}

extension WodSetModel {
    
    static var fake: Self {
        .init(workoutId: UUID(), wodModelId: UUID(), data: WodSetEntity.fake)
    }
    
}

