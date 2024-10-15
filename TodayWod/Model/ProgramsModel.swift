//
//  ProgramModel.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

struct ProgramModel: Codable, Equatable, Identifiable {

    var id: UUID
    
    let methodType: ProgramMethodType
    let level: LevelType
    var dayWorkouts: [DayWorkoutModel]
    
    init(data: ProgramEntity) {
        self.id = UUID()
        
        self.methodType = data.methodType
        self.level = data.level
        self.dayWorkouts = data.dayWorkouts.map { DayWorkoutModel(data: $0) }
    }
    
    init(coreData: ProgramCoreEntity) {
        self.id = coreData.id
        self.methodType = ProgramMethodType(rawValue: coreData.methodType) ?? .body
        self.level = LevelType(rawValue: coreData.level) ?? .beginner
        self.dayWorkouts = coreData.dayWorkouts
            .compactMap { $0 as? DayWorkoutCoreEntity}
            .map { DayWorkoutModel(coreData: $0) }
    }
    
}

extension ProgramModel {
    
    var hasOwnProgram: Bool {
        self.dayWorkouts.count != 0
    }
    
}

extension ProgramModel {
    
    static let bodyBeginner: Self = .init(data: ProgramEntity.bodyBeginner)
    
    static let bodyBeginners: [Self] = ProgramEntity.bodyBeginners.map { ProgramModel(data: $0) }

}

struct DayWorkoutModel: Codable, Equatable, Identifiable {
    
    var id: UUID
    var date: Date? // 성공한 날짜.
    var duration: Int
    
    let type: DayWorkoutTagType
    let title: String
    let subTitle: String
    let expectedMinute: Int
    let minExpectedCalorie: Int
    let maxExpectedCalorie: Int
    var workouts: [WorkoutModel]
    
    init(data: DayWorkoutEntity) {
        self.id = UUID()
        self.date = nil
        self.duration = 0
        
        self.type = data.type
        self.title = data.title
        self.subTitle = data.subTitle
        self.expectedMinute = data.expectedMinute
        self.minExpectedCalorie = data.minExpectedCalorie
        self.maxExpectedCalorie = data.maxExpectedCalorie
        self.workouts = data.workouts.map { WorkoutModel(data: $0) }
    }
    
    init(coreData: DayWorkoutCoreEntity) {
        self.id = coreData.id
        self.date = coreData.date
        self.duration = Int(coreData.duration)
        
        self.type = DayWorkoutTagType(rawValue: coreData.type) ?? .default
        self.title = coreData.title
        self.subTitle = coreData.subTitle
        self.expectedMinute = Int(coreData.expectedMinute)
        self.minExpectedCalorie = Int(coreData.minExpectedCalorie)
        self.maxExpectedCalorie = Int(coreData.maxExpectedCalorie)
        self.workouts = coreData.workouts
            .compactMap { $0 as? WorkoutCoreEntity}
            .map { WorkoutModel(coreData: $0) }
    }
    
}

extension DayWorkoutModel {
    
    var isCompleted: Bool {
        workouts.flatMap {
            $0.wods.flatMap { $0.wodSets }
        }.allSatisfy { $0.isCompleted }
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
    
    var completedSetCount: Int {
        self.workouts.reduce(0) { $0 + $1.completedSetCount }
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
