//
//  RecentActivitesModel.swift
//  TodayWod
//
//  Created by 오지연 on 10/17/24.
//

import Foundation

struct RecentActivitiesModel: Codable, Equatable, Identifiable {
    
    var id: UUID
    let dayWorkouts: [DayWorkoutModel]
    
    init(dayWorkouts: [DayWorkoutModel]) {
        self.id = UUID()
        self.dayWorkouts = dayWorkouts
    }
    
    init(coreData: RecentActivitiesCoreEntity) {
        self.id = coreData.id
        self.dayWorkouts = coreData.dayWorkouts
            .compactMap { $0 as? DayWorkoutCoreEntity}
            .map { DayWorkoutModel(coreData: $0) }
    }
    
}
