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

    func getCurrentProgram() throws -> ProgramModel {
        do {
            guard let result = try fetchProgram() else { throw CoreDataError.emptyData }
            
            return ProgramModel(coreData: result)
        } catch {
            throw error
        }
    }
    
    func getDayWorkoutEntities() throws -> [DayWorkoutModel] {
        guard let programEntity = try self.fetchProgram() else { return [] }
        let dayWorkOutEntities = programEntity.dayWorkouts.compactMap { $0 as? DayWorkoutCoreEntity }

        return dayWorkOutEntities.map {
            DayWorkoutModel(coreData: $0)
        }
    }

    func setProgram(model: ProgramModel) async throws -> ProgramModel {
        try await context.perform {
            do {
                try self.removeProgram()
            } catch {
                throw error
            }
            
            _ = ProgramCoreEntity.instance(with: self.context, model: model)
            
            WodCoreData.shared.saveContext()
        }

        return model
    }
    
    func updateProgram(day: DayWorkoutModel) async throws {
        try await context.perform {
            guard let programEntity = try self.fetchProgram() else { return }
            var currentProgram = ProgramModel(coreData: programEntity)
            
            let dayWorkouts: [DayWorkoutModel] = currentProgram.dayWorkouts.map {
                $0.id == day.id ? day : $0
            }
            currentProgram.dayWorkouts = dayWorkouts
            
            do {
                try self.removeProgram()
            } catch {
                throw error
            }
            
            _ = ProgramCoreEntity.instance(with: self.context, model: currentProgram)
            
            WodCoreData.shared.saveContext()
        }
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
        let firstWod = wodInfo.first

        return firstWod
    }

    func fetchPrograms() throws -> [ProgramCoreEntity] {
        return try context.fetch(WodCoreData.shared.fetchProgram())
    }

}


enum CoreDataError: Error {
    case emptyData
}
