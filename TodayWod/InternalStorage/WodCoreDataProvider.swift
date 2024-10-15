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

    func getDayWorkoutEntities() throws -> [DayWorkoutModel] {
        guard let programEntity = try self.fetchProgram() else { return [] }
        let dayWorkOutEntities = programEntity.dayWorkouts.compactMap { $0 as? DayWorkoutCoreEntity }

        return dayWorkOutEntities.map {
            DayWorkoutModel(coreData: $0)
        }
    }

    func setProgram(model: ProgramModel) throws -> ProgramModel {
        _ = ProgramCoreEntity.instance(with: self.context, model: model)
        
        WodCoreData.shared.saveContext()

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

    func fetchProgram() throws -> ProgramCoreEntity? {
        let wodInfo = try context.fetch(WodCoreData.shared.fetchProgram())
        print(wodInfo.count)
        let firstWod = wodInfo.first

        return firstWod
    }

    func fetchPrograms() throws -> [ProgramCoreEntity] {
        return try context.fetch(WodCoreData.shared.fetchProgram())
    }

}
