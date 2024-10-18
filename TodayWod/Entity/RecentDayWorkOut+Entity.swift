//
//  RecentDayWorkOut+Entity.swift
//  TodayWod
//
//  Created by 오지연 on 10/13/24.
//
import Foundation

struct RecentActivitiesEntity: Codable, Equatable {
    
    let dayWorkouts: [DayWorkoutEntity]
    
}
