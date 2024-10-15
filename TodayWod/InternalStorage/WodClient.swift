//
//  WodClient.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 10/11/24.
//

import Foundation
import ComposableArchitecture

struct WodClient {
    var getDayModels: () throws -> [DayWorkoutModel]
    var addWodProgram: (ProgramModel) async throws -> ProgramModel
    var removePrograms: () throws -> Void
}

extension WodClient: DependencyKey {

    static let liveValue: WodClient = Self(getDayModels: {
        try WodCoreDataProvider.shared.getDayWorkoutEntities()
    }, addWodProgram: { programsModel in
        try await WodCoreDataProvider.shared.setProgram(model: programsModel) // TOOD: 호출부에 파람 추가하여 3가지 프로그램 중 랜덤 값을 세팅하도록 수정
    }, removePrograms: {
        try WodCoreDataProvider.shared.removeProgram()
    })

}

extension DependencyValues {

    var wodClient: WodClient {
        get { self[WodClient.self] }
        set { self[WodClient.self] = newValue }
    }

}


