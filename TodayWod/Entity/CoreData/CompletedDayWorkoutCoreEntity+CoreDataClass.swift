//
//  CompletedDayWorkoutCoreEntity+CoreDataClass.swift
//  TodayWod
//
//  Created by 오지연 on 10/21/24.
//
//

import Foundation
import CoreData

@objc(CompletedDayWorkoutCoreEntity)
public class CompletedDayWorkoutCoreEntity: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
    
}

extension CompletedDayWorkoutCoreEntity {
    
    static func instance(with context: NSManagedObjectContext, model: CompletedDateModel) -> CompletedDayWorkoutCoreEntity {
        let newItem = CompletedDayWorkoutCoreEntity(context: context)
        newItem.id = model.id
        newItem.duration = Int64(model.duration)
        newItem.date = model.date
        return newItem
    }
    
}
