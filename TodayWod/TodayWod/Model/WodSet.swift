//
//  WodSet.swift
//  TodayWod
//
//  Created by D프로젝트노드_오지연 on 9/24/24.
//

import Foundation

struct WodSet: Codable, Equatable, Identifiable {

    var id: UUID
    var workOutId: UUID
    var wodModelId: UUID
    
    let order: Int
    var unitValue: Int
    var isCompleted: Bool
    
    init(workOutId: UUID, wodModelId: UUID, data: WodSetEntity) {
        self.id = UUID()
        self.workOutId = workOutId
        self.wodModelId = wodModelId
        
        self.order = data.order
        self.unitValue = data.unitValue
        self.isCompleted = data.isCompleted
    }
    
}

extension WodSet {
    
    var displaySetNumber: String {
        String(self.order + 1)
    }
    
    var displayUnitValue: String {
        String(self.unitValue)
    }
    
}

extension WodSet {
    
    static var fake: Self {
        .init(workOutId: UUID(), wodModelId: UUID(), data: WodSetEntity.fake)
    }
    
}

