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

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
    
}

extension RecentActivitiesCoreEntity {
    
    static func instance(with context: NSManagedObjectContext, model: RecentActivitiesModel) -> RecentActivitiesCoreEntity {
        let newItem = RecentActivitiesCoreEntity(context: context)
        newItem.id = model.id
        let dayWorkouts = DayWorkoutCoreEntity.createProgramEntities(with: context, programModel: model.dayWorkouts)
        newItem.dayWorkouts = NSOrderedSet(array: dayWorkouts)
        return newItem
    }
    
}
