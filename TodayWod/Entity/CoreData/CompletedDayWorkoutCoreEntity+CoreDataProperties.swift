//
//  CompletedDayWorkoutCoreEntity+CoreDataProperties.swift
//  TodayWod
//
//  Created by 오지연 on 10/21/24.
//
//

import Foundation
import CoreData


extension CompletedDayWorkoutCoreEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompletedDayWorkoutCoreEntity> {
        return NSFetchRequest<CompletedDayWorkoutCoreEntity>(entityName: "CompletedDayWorkoutCoreEntity")
    }

    @NSManaged public var date: Date
    @NSManaged public var duration: Int64
    @NSManaged public var id: UUID

}

extension CompletedDayWorkoutCoreEntity : Identifiable {

}
