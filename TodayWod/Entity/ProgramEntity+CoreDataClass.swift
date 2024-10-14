//
//  ProgramEntity+CoreDataClass.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//
//

import Foundation
import CoreData

@objc(ProgramEntity)
public class ProgramEntity: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
    
}

extension ProgramEntity {

    static func instance(with context: NSManagedObjectContext, model: ProgramModel) -> ProgramEntity {
        let newWodInfoEntity = ProgramEntity(context: context)
        newWodInfoEntity.id = model.id
        newWodInfoEntity.level = model.level.rawValue
        newWodInfoEntity.methodType = model.methodType.rawValue
        let weeklyWorkoutProgram = DayWorkoutEntity.createProgramEntities(with: context, programModel: model.dayWorkouts)
        newWodInfoEntity.dayWorkouts = NSOrderedSet(array: weeklyWorkoutProgram)

        return newWodInfoEntity
    }

}
