//
//  ProgramCoreEntity+CoreDataClass.swift
//  TodayWod
//
//  Created by 오지연 on 10/15/24.
//
//

import Foundation
import CoreData

@objc(ProgramCoreEntity)
public class ProgramCoreEntity: NSManagedObject {
    
}

extension ProgramCoreEntity {

    static func instance(with context: NSManagedObjectContext, model: ProgramModel) -> ProgramCoreEntity {
        let newWodInfoEntity = ProgramCoreEntity(context: context)
        newWodInfoEntity.id = model.id
        newWodInfoEntity.level = model.level.rawValue
        newWodInfoEntity.methodType = model.methodType.rawValue
        let dayWorkouts = DayWorkoutCoreEntity.createProgramEntities(with: context, programModel: model.dayWorkouts)
        newWodInfoEntity.dayWorkouts = NSOrderedSet(array: dayWorkouts)

        return newWodInfoEntity
    }

}
