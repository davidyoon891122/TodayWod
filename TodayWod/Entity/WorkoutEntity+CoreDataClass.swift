//
//  DayWorkoutEntity+CoreDataClass.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//
//

import Foundation
import CoreData

@objc(WorkoutEntity)
public class WorkoutEntity: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
    
}

extension WorkoutEntity {

    static func createWorkoutInfoEntities(with context: NSManagedObjectContext, models: [TobeWorkoutModel]) -> [WorkoutEntity] {
        return models.map { model in
            let newItem = WorkoutEntity(context: context)
            newItem.id = model.id
            newItem.type = model.type.rawValue
            let wods = WodEntity.createWorkoutItemEntity(with: context, models: model.wods)
            newItem.wods = NSOrderedSet(array: wods)
            return newItem
        }
    }

}