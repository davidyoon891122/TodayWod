//
//  WodSetCoreEntity+CoreDataProperties.swift
//  TodayWod
//
//  Created by D프로젝트노드_오지연 on 10/15/24.
//
//

import Foundation
import CoreData

extension WodSetCoreEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WodSetCoreEntity> {
        return NSFetchRequest<WodSetCoreEntity>(entityName: "WodSetCoreEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var isCompleted: Bool
    @NSManaged public var order: Int64
    @NSManaged public var unitValue: Int64
    @NSManaged public var workoutId: UUID
    @NSManaged public var wodModelId: UUID

}

extension WodSetCoreEntity : Identifiable {

}
