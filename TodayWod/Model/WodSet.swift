//
//  WodSet.swift
//  TodayWod
//
//  Created by D프로젝트노드_오지연 on 9/24/24.
//

import Foundation

struct WodSet: Codable, Equatable, Identifiable {

    var id: UUID
    var workOutInfoId: UUID?
    var wodModelId: UUID?
    
    var unitValue: Int
    var number: Int?
    var isCompleted: Bool
    
    init(unitValue: Int, number: Int? = nil, isCompleted: Bool = false) {
        self.id = UUID()
        self.workOutInfoId = nil
        self.wodModelId = nil
        
        self.unitValue = unitValue
        self.number = number
        self.isCompleted = isCompleted
    }
    
}

extension WodSet {
    
    var displaySetNumber: String {
        String(self.number ?? 1)
    }
    
    var displayUnitValue: String {
        String(self.unitValue)
    }
    
    func createNumbering(set: Int, workOutInfoId: UUID?, wodModelId: UUID) -> [WodSet] {
        (0..<set).map { idx in
            var updatedSet = self
            updatedSet.id = UUID()
            updatedSet.workOutInfoId = workOutInfoId
            updatedSet.wodModelId = wodModelId
            updatedSet.number = idx + 1
            return updatedSet
        }
    }
    
}

extension WodSet {
    
    static var fake: Self {
        .init(unitValue: 2, isCompleted: true)
    }
    
}

