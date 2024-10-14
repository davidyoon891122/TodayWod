//
//  DayWorkoutEntity+CoreDataProperties.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//
//

import Foundation
import CoreData


extension WorkoutEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutEntity> {
        return NSFetchRequest<WorkoutEntity>(entityName: "DayWorkoutEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var type: String
    @NSManaged public var wods: NSOrderedSet

}

// MARK: Generated accessors for wods
extension WorkoutEntity {

    @objc(insertObject:inWodsAtIndex:)
    @NSManaged public func insertIntoWods(_ value: WodEntity, at idx: Int)

    @objc(removeObjectFromWodsAtIndex:)
    @NSManaged public func removeFromWods(at idx: Int)

    @objc(insertWods:atIndexes:)
    @NSManaged public func insertIntoWods(_ values: [WodEntity], at indexes: NSIndexSet)

    @objc(removeWodsAtIndexes:)
    @NSManaged public func removeFromWods(at indexes: NSIndexSet)

    @objc(replaceObjectInWodsAtIndex:withObject:)
    @NSManaged public func replaceWods(at idx: Int, with value: WodEntity)

    @objc(replaceWodsAtIndexes:withWods:)
    @NSManaged public func replaceWods(at indexes: NSIndexSet, with values: [WodEntity])

    @objc(addWodsObject:)
    @NSManaged public func addToWods(_ value: WodEntity)

    @objc(removeWodsObject:)
    @NSManaged public func removeFromWods(_ value: WodEntity)

    @objc(addWods:)
    @NSManaged public func addToWods(_ values: NSOrderedSet)

    @objc(removeWods:)
    @NSManaged public func removeFromWods(_ values: NSOrderedSet)

}

extension WorkoutEntity : Identifiable {

}
