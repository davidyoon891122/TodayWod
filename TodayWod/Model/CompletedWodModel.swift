//
//  CompletedWodModel.swift
//  TodayWod
//
//  Created by 오지연 on 10/13/24.
//

import Foundation

struct CompletedDayWorkoutModel: Codable, Equatable, Identifiable {
    
    var id: UUID
    let date: Date?
    let duration: Int
    
    init(data: CompletedDayWorkoutEntity) {
        self.id = UUID()
        
        self.date = data.date
        self.duration = data.duration
    }
    
    init(coreData: CompletedDayWorkoutCoreEntity) {
        self.id = coreData.id
        self.date = coreData.date
        self.duration = Int(coreData.duration)
    }
    
}

extension CompletedDayWorkoutModel {

    static let fake: Self = .init(data: CompletedDayWorkoutEntity.fake)

}
