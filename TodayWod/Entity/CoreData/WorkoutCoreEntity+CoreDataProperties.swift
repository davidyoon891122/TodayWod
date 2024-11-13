//
//  WorkoutCoreEntity+CoreDataProperties.swift
//  TodayWod
//
//  Created by 오지연 on 10/15/24.
//
//

import Foundation
import CoreData


extension WorkoutCoreEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutCoreEntity> {
        return NSFetchRequest<WorkoutCoreEntity>(entityName: "WorkoutCoreEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var type: String
    @NSManaged public var wods: NSOrderedSet

}

// MARK: Generated accessors for wods
extension WorkoutCoreEntity {

    @objc(insertObject:inWodsAtIndex:)
    @NSManaged public func insertIntoWods(_ value: WodCoreEntity, at idx: Int)

    @objc(removeObjectFromWodsAtIndex:)
    @NSManaged public func removeFromWods(at idx: Int)

    @objc(insertWods:atIndexes:)
    @NSManaged public func insertIntoWods(_ values: [WodCoreEntity], at indexes: NSIndexSet)

    @objc(removeWodsAtIndexes:)
    @NSManaged public func removeFromWods(at indexes: NSIndexSet)

    @objc(replaceObjectInWodsAtIndex:withObject:)
    @NSManaged public func replaceWods(at idx: Int, with value: WodCoreEntity)

    @objc(replaceWodsAtIndexes:withWods:)
    @NSManaged public func replaceWods(at indexes: NSIndexSet, with values: [WodCoreEntity])

    @objc(addWodsObject:)
    @NSManaged public func addToWods(_ value: WodCoreEntity)

    @objc(removeWodsObject:)
    @NSManaged public func removeFromWods(_ value: WodCoreEntity)

    @objc(addWods:)
    @NSManaged public func addToWods(_ values: NSOrderedSet)

    @objc(removeWods:)
    @NSManaged public func removeFromWods(_ values: NSOrderedSet)

}

extension WorkoutCoreEntity : Identifiable {

}
