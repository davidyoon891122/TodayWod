//
//  WorkoutCoreEntity+CoreDataClass.swift
//  TodayWod
//
//  Created by D프로젝트노드_오지연 on 10/15/24.
//
//

import Foundation
import CoreData

@objc(WorkoutCoreEntity)
public class WorkoutCoreEntity: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
    
}

extension WorkoutCoreEntity {

    static func createWorkoutInfoEntities(with context: NSManagedObjectContext, models: [WorkoutModel]) -> [WorkoutCoreEntity] {
        return models.map { model in
            let newItem = WorkoutCoreEntity(context: context)
            newItem.id = model.id
            newItem.type = model.type.rawValue
            let wods = WodCoreEntity.createWorkoutItemEntity(with: context, models: model.wods)
            newItem.wods = NSOrderedSet(array: wods)
            return newItem
        }
    }

}
