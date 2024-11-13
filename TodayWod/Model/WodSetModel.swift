//
//  WodSetModel.swift
//  TodayWod
//
//  Created by 오지연 on 9/24/24.
//

import Foundation

struct WodSetModel: Codable, Equatable, Identifiable {

    var id: String
    let order: Int
    var unitValue: Int
    var isCompleted: Bool
    
    init(unitValue: Int, order: Int = 1) {
        self.id = UUID().uuidString
        
        self.unitValue = unitValue
        self.order = order
        self.isCompleted = false
    }
    
    init(data: WodSetEntity) {
        self.id = data.id
        self.order = data.order
        self.unitValue = data.unitValue
        self.isCompleted = data.isCompleted
    }
    
    init(coreData: WodSetCoreEntity) {
        self.id = coreData.id
        self.order = Int(coreData.order)
        self.unitValue = Int(coreData.unitValue)
        self.isCompleted = coreData.isCompleted
    }
    
}

extension WodSetModel {
    
    var displaySetNumber: String {
        String(self.order)
    }
    
    var displayUnitValue: String {
        String(self.unitValue)
    }
    
}

extension WodSetModel {
    
    static var fake: Self {
        .init(data: WodSetEntity.fake)
    }
    
}

