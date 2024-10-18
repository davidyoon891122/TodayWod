//
//  WodClient.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 10/11/24.
//

import Foundation
import ComposableArchitecture

struct WodClient {
    
    static let coreData = WodCoreData()
    
    var getCurrentProgram: () throws -> ProgramModel
    var getDayModels: () throws -> [DayWorkoutModel]
    var addWodProgram: (ProgramModel) async throws -> ProgramModel
    var updateWodProgram: (DayWorkoutModel) async throws -> Void
    var removePrograms: () throws -> Void
    var getRecentDayWorkouts: () throws -> [DayWorkoutModel]
    var addRecentDayWorkouts: (DayWorkoutModel) async throws -> Void
    
}

extension WodClient: DependencyKey {
    
    static var wodProvider: WodCoreDataProvider {
        .init(coreData: WodClient.coreData)
    }
    
    static var recentWodProvider: RecentWodCoreDataProvider {
        .init(coreData: WodClient.coreData)
    }

    static let liveValue: WodClient = Self(getCurrentProgram: {
        try WodClient.wodProvider.getCurrentProgram()
    }, getDayModels: {
        try WodClient.wodProvider.getDayWorkoutEntities()
    }, addWodProgram: { programsModel in
        try await WodClient.wodProvider.setProgram(model: programsModel) // TOOD: 호출부에 파람 추가하여 3가지 프로그램 중 랜덤 값을 세팅하도록 수정
    }, updateWodProgram: { dayWorkout in
        try await WodClient.wodProvider.updateProgram(day: dayWorkout)
    }, removePrograms: {
        try WodClient.wodProvider.removeProgram()
    }, getRecentDayWorkouts: {
        try WodClient.recentWodProvider.getRecentActivities()
    }, addRecentDayWorkouts: { dayWorkout in
        try await WodClient.recentWodProvider.setRecentActivities(model: dayWorkout)
    })

}

extension DependencyValues {

    var wodClient: WodClient {
        get { self[WodClient.self] }
        set { self[WodClient.self] = newValue }
    }

}


