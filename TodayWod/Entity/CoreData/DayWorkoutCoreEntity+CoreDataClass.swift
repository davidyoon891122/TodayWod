//
//  DayWorkoutCoreEntity+CoreDataClass.swift
//  TodayWod
//
//  Created by D프로젝트노드_오지연 on 10/15/24.
//
//

import Foundation
import CoreData

@objc(DayWorkoutCoreEntity)
public class DayWorkoutCoreEntity: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
    
}

extension DayWorkoutCoreEntity {

    static func createProgramEntities(with context: NSManagedObjectContext, programModel: [DayWorkoutModel]) -> [DayWorkoutCoreEntity] {
        programModel.map { model in
            let newItem = DayWorkoutCoreEntity(context: context)
            newItem.id = model.id
            newItem.duration = Int64(model.duration)
            newItem.date = model.date
            newItem.type = model.type.rawValue
            newItem.title = model.title
            newItem.subTitle = model.subTitle
            newItem.expectedMinute = Int64(model.expectedMinute)
            newItem.minExpectedCalorie = Int64(model.minExpectedCalorie)
            newItem.maxExpectedCalorie = Int64(model.maxExpectedCalorie)
            let workOutInfos = WorkoutCoreEntity.createWorkoutInfoEntities(with: context, models: model.workouts)
            newItem.workouts = NSOrderedSet(array: workOutInfos)
            newItem.imageName = model.imageName
            return newItem
        }
    }

    static func convertToEntity(with context: NSManagedObjectContext, model: DayWorkoutModel) -> DayWorkoutCoreEntity {
        let newItem = DayWorkoutCoreEntity(context: context)
        newItem.id = model.id
        newItem.title = model.title
        newItem.subTitle = model.subTitle
        newItem.expectedMinute = Int64(model.expectedMinute)
        newItem.minExpectedCalorie = Int64(model.minExpectedCalorie)
        newItem.maxExpectedCalorie = Int64(model.maxExpectedCalorie)
        newItem.type = model.type.rawValue
        newItem.workouts = NSOrderedSet(array: WorkoutCoreEntity.createWorkoutInfoEntities(with: context, models: model.workouts))

        return newItem
    }

}
