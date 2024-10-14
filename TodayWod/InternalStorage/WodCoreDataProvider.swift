//
//  WodCoreDataProvider.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//

import Foundation

final class WodCoreDataProvider {

    static let shared = WodCoreDataProvider()

    private let context = WodCoreData.shared.context

    func getWeeklyWorkoutEntities() throws -> [DayWorkoutModel] {
        guard let programEntity = try self.fetchWodInfo() else { return [] }
        let weeklyWorkOutEntities = programEntity.dayWorkouts.compactMap { $0 as? DayWorkoutEntity }

        return weeklyWorkOutEntities.map {
            DayWorkoutModel(entity: $0)
        }
    }

    func setProgram(model: ProgramModel) throws -> ProgramModel {
        _ = ProgramEntity.instance(with: self.context, model: model)
        
        try self.context.save()

        return model
    }

    func removeProgram() throws -> Void {
        let currentPrograms = try fetchPrograms()

        currentPrograms.forEach {
            context.delete($0)
        }

        try context.save()
    }

}

private extension WodCoreDataProvider {

    func fetchWodInfo() throws -> ProgramEntity? {
        let wodInfo = try context.fetch(WodCoreData.shared.fetchProgram())
        print(wodInfo.count)
        let firstWod = wodInfo.first

        return firstWod
    }

    func fetchPrograms() throws -> [ProgramEntity] {
        return try context.fetch(WodCoreData.shared.fetchProgram())
    }

}
