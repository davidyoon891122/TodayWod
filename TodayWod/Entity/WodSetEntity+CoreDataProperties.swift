//
//  WodSetEntity+CoreDataProperties.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//
//

import Foundation
import CoreData


extension WodSetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WodSetEntity> {
        return NSFetchRequest<WodSetEntity>(entityName: "WodSetEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var isCompleted: Bool
    @NSManaged public var order: Int64
    @NSManaged public var unitValue: Int64

}

extension WodSetEntity : Identifiable {

}
