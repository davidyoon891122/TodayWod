//
//  RecentDayWorkoutModel.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/21/24.
//

import Foundation

struct RecentDayWorkoutModel: Codable, Equatable, Identifiable {

    var id: UUID
    
    let date: Date?
    let duration: Int
    let type: DayWorkoutTagType
    let title: String
    let subTitle: String
    let expectedMinute: Int
    let minExpectedCalorie: Int
    let maxExpectedCalorie: Int
    var workouts: [WorkoutModel]
    
    init(data: RecentDayWorkoutEntity) {
        self.id = UUID()
        
        self.date = data.date
        self.duration = data.duration
        self.type = data.type
        self.title = data.title
        self.subTitle = data.subTitle
        self.expectedMinute = data.expectedMinute
        self.minExpectedCalorie = data.minExpectedCalorie
        self.maxExpectedCalorie = data.maxExpectedCalorie
        self.workouts = data.workouts.map { WorkoutModel(data: $0) }
    }

}

extension RecentDayWorkoutModel {
    
    var displayDate: String {
        date?.toString ?? ""
    }
    
}

extension RecentDayWorkoutModel {

    static let fakes: [Self] = RecentDayWorkoutEntity.fakes.map { .init(data: $0) }

}
