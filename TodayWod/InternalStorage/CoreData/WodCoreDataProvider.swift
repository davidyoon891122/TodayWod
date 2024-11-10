//
//  WodCoreDataProvider.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//

import Foundation
import CoreData

final class WodCoreDataProvider {

    private let coreData: WodCoreData
    
    init(coreData: WodCoreData) {
        self.coreData = coreData
    }
    
    private var context: NSManagedObjectContext {
        self.coreData.context
    }

    func getCurrentProgram() async throws -> ProgramModel {
        try await context.perform {
            do {
                guard let result = try self.fetchProgram() else { throw CoreDataError.emptyData }
                
                return ProgramModel(coreData: result)
            } catch {
                throw error
            }
        }
    }
    
    func getDayWorkoutEntities() async throws -> [DayWorkoutModel] {
        try await context.perform {
            guard let programEntity = try self.fetchProgram() else { return [] }
            let dayWorkOutEntities = programEntity.dayWorkouts.compactMap { $0 as? DayWorkoutCoreEntity }
            
            return dayWorkOutEntities.map {
                DayWorkoutModel(coreData: $0)
            }
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
            
            self.coreData.saveContext()
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
            
            self.coreData.saveContext()
        }
    }

    func removeProgram() throws -> Void {
        let currentPrograms = try self.fetchPrograms()
        
        currentPrograms.forEach {
            self.context.delete($0)
        }
        
        try self.context.save()
    }

}

private extension WodCoreDataProvider {

    func fetchProgram() throws -> ProgramCoreEntity? {
        let wodInfo = try context.fetch(self.coreData.programFetchRequest)
        print(wodInfo.count)
        let firstWod = wodInfo.first

        return firstWod
    }

    func fetchPrograms() throws -> [ProgramCoreEntity] {
        return try context.fetch(self.coreData.programFetchRequest)
    }

}
