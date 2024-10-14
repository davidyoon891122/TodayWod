//
//  DayWorkoutEntity+CoreDataClass.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//
//

import Foundation
import CoreData

@objc(DayWorkoutEntity)
public class DayWorkoutEntity: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
    
}

extension DayWorkoutEntity {

    static func createProgramEntities(with context: NSManagedObjectContext, programModel: [TobeDayWorkoutModel]) -> [DayWorkoutEntity] {
        programModel.map { model in
            let newItem = DayWorkoutEntity(context: context)
            newItem.id = model.id
            newItem.type = model.type.rawValue
            newItem.title = model.title
            newItem.subTitle = model.subTitle
            newItem.expectedMinutes = Int64(model.expectedMinutes)
            newItem.minExpectedCalorie = Int64(model.minExpectedCalorie)
            newItem.maxExpectedCalorie = Int64(model.maxExpectedCalorie)
            let workOutInfos = WorkoutEntity.createWorkoutInfoEntities(with: context, models: model.workouts)
            newItem.workouts = NSOrderedSet(array: workOutInfos)
            return newItem
        }
    }

    static func convertToEntity(with context: NSManagedObjectContext, model: TobeDayWorkoutModel) -> DayWorkoutEntity {
        let newItem = DayWorkoutEntity(context: context)
        newItem.id = model.id
        newItem.title = model.title
        newItem.subTitle = model.subTitle
        newItem.expectedMinutes = Int64(model.expectedMinutes)
        newItem.minExpectedCalorie = Int64(model.minExpectedCalorie)
        newItem.maxExpectedCalorie = Int64(model.maxExpectedCalorie)
        newItem.type = model.type.rawValue
        newItem.workouts = NSOrderedSet(array: WorkoutEntity.createWorkoutInfoEntities(with: context, models: model.workouts))

        return newItem
    }

}
