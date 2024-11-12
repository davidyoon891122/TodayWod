//
//  RecentActivitiesCoreEntity+CoreDataClass.swift
//  TodayWod
//
//  Created by 오지연 on 10/17/24.
//
//

import Foundation
import CoreData

@objc(RecentActivitiesCoreEntity)
public class RecentActivitiesCoreEntity: NSManagedObject {

}

extension RecentActivitiesCoreEntity {

    static func instance(with context: NSManagedObjectContext, model: DayWorkoutModel) -> RecentActivitiesCoreEntity {
        let newItem = RecentActivitiesCoreEntity(context: context)
        newItem.id = model.id
        newItem.duration = Int64(model.duration)
        newItem.date = model.date
        newItem.type = model.type.rawValue
        newItem.title = model.title
        newItem.subTitle = model.subTitle
        newItem.expectedMinute = Int64(model.expectedMinute)
        newItem.minExpectedCalorie = Int64(model.minExpectedCalorie)
        newItem.maxExpectedCalorie = Int64(model.maxExpectedCalorie)
        newItem.workouts = NSOrderedSet(array: WorkoutCoreEntity.createWorkoutInfoEntities(with: context, models: model.workouts))
        newItem.imageName = model.imageName

        return newItem
    }
    
}
