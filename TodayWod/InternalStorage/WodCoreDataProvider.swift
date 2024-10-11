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

    func getWeeklyWorkoutEntities() throws -> [WeeklyWorkoutModel] {
        guard let programEntity = try self.fetchWodInfo() else { return [] }
        let weeklyWorkOutEntities = programEntity.weeklyWorkouts.compactMap { $0 as? WeeklyWorkoutEntity }

        return weeklyWorkOutEntities.map {
            WeeklyWorkoutModel(entity: $0)
        }
    }

    func setProgram(model: ProgramsModel) throws -> ProgramsModel {
        _ = ProgramsEntity.instance(with: self.context, model: .mock)

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

    func fetchWodInfo() throws -> ProgramsEntity? {
        let wodInfo = try context.fetch(WodCoreData.shared.fetchProgram())
        let firstWod = wodInfo.first

        return firstWod
    }

    func fetchPrograms() throws -> [ProgramsEntity] {
        return try context.fetch(WodCoreData.shared.fetchProgram())
    }

}
