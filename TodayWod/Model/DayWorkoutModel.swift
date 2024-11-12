//
//  DayWorkoutModel.swift
//  TodayWod
//
//  Created by 오지연 on 11/12/24.
//

import Foundation

struct DayWorkoutModel: Codable, Equatable, Identifiable {
    
    var date: Date? // 성공한 날짜.
    var duration: Int
    
    var id: String
    let type: DayWorkoutTagType
    let title: String
    let subTitle: String
    let expectedMinute: Int
    let minExpectedCalorie: Int
    let maxExpectedCalorie: Int
    var workouts: [WorkoutModel]
    let imageName: String

    init(data: DayWorkoutEntity) {
        self.date = nil
        self.duration = 0
        
        self.id = data.id
        self.type = data.type
        self.title = data.title
        self.subTitle = data.subTitle
        self.expectedMinute = data.expectedMinute
        self.minExpectedCalorie = data.minExpectedCalorie
        self.maxExpectedCalorie = data.maxExpectedCalorie
        self.workouts = data.workouts.map { WorkoutModel(data: $0) }
        self.imageName = data.imageName
    }
    
    init(coreData: DayWorkoutCoreEntity) {
        self.date = coreData.date
        self.duration = Int(coreData.duration)
        
        self.id = coreData.id
        self.type = DayWorkoutTagType(rawValue: coreData.type) ?? .default
        self.title = coreData.title
        self.subTitle = coreData.subTitle
        self.expectedMinute = Int(coreData.expectedMinute)
        self.minExpectedCalorie = Int(coreData.minExpectedCalorie)
        self.maxExpectedCalorie = Int(coreData.maxExpectedCalorie)
        self.workouts = coreData.workouts
            .compactMap { $0 as? WorkoutCoreEntity}
            .map { WorkoutModel(coreData: $0) }
        self.imageName = coreData.imageName
    }
    
    init(recentCoreData: RecentActivitiesCoreEntity) {
        self.date = recentCoreData.date
        self.duration = Int(recentCoreData.duration)
        
        self.id = recentCoreData.id
        self.type = DayWorkoutTagType(rawValue: recentCoreData.type) ?? .default
        self.title = recentCoreData.title
        self.subTitle = recentCoreData.subTitle
        self.expectedMinute = Int(recentCoreData.expectedMinute)
        self.minExpectedCalorie = Int(recentCoreData.minExpectedCalorie)
        self.maxExpectedCalorie = Int(recentCoreData.maxExpectedCalorie)
        self.workouts = recentCoreData.workouts
            .compactMap { $0 as? WorkoutCoreEntity}
            .map { WorkoutModel(coreData: $0) }
        self.imageName = recentCoreData.imageName
    }
    
}

extension DayWorkoutModel {
    
    var isContainCompleted: Bool {
        workouts.contains { $0.isContainCompleted }
    }
    
    var isCompleted: Bool {
        workouts.allSatisfy { $0.isCompleted } || date != nil // 운동 완료 or 운동 종료 모두 성공 처리.
    }
    
    var displayExpectedMinuteTitle: String {
        "예상 시간"
    }
    
    var displayEstimatedCalorieTitle: String {
        "예상 소모 Kcal"
    }
    
    var displayExpectedMinute: String {
        "약 \(expectedMinute)분"
    }
    
    var displayEstimatedCalorie: String {
        "약 \(minExpectedCalorie)~\(maxExpectedCalorie) Kcal"
    }
    
    var completedWodsCount: Int {
        self.workouts.reduce(0) { $0 + $1.completedWodsCount }
    }
    
}

// 최근 활동.
extension DayWorkoutModel {
    
    var displayDate: String {
        date?.toString ?? ""
    }
    
}

extension DayWorkoutModel {
    
    static let fake: Self = .init(data: DayWorkoutEntity.fake)
    
    static let completedFake: Self = {
        var item = DayWorkoutModel.fake
        item.date = Date()
        return item
    }()
    
    static var fakes: [Self] = {
        return DayWorkoutEntity.bodyBeginnerAlphaWeek.map { fake -> DayWorkoutModel in
            .init(data: fake)
        }
    }()
    
}
