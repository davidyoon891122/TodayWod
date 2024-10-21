//
//  CompletedDateModel.swift
//  TodayWod
//
//  Created by 오지연 on 10/13/24.
//

import Foundation

struct CompletedDateModel: Codable, Equatable, Identifiable {
    
    var id: UUID
    let date: Date
    let duration: Int
    
    init(date: Date, duration: Int) {
        self.id = UUID()
        
        self.date = date
        self.duration = duration
    }
    
    init(coreData: CompletedDayWorkoutCoreEntity) {
        self.id = coreData.id
        self.date = coreData.date
        self.duration = Int(coreData.duration)
    }
    
}
