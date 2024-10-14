//
//  ProgramCoreEntity+CoreDataClass.swift
//  TodayWod
//
//  Created by D프로젝트노드_오지연 on 10/15/24.
//
//

import Foundation
import CoreData

@objc(ProgramCoreEntity)
public class ProgramCoreEntity: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
    
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
