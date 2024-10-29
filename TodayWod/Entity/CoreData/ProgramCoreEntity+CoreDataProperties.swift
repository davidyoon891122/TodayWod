//
//  ProgramCoreEntity+CoreDataProperties.swift
//  TodayWod
//
//  Created by D프로젝트노드_오지연 on 10/15/24.
//
//

import Foundation
import CoreData


extension ProgramCoreEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProgramCoreEntity> {
        return NSFetchRequest<ProgramCoreEntity>(entityName: "ProgramCoreEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var level: String
    @NSManaged public var methodType: String
    @NSManaged public var dayWorkouts: NSOrderedSet

}

// MARK: Generated accessors for dayWorkouts
extension ProgramCoreEntity {

    @objc(insertObject:inDayWorkoutsAtIndex:)
    @NSManaged public func insertIntoDayWorkouts(_ value: DayWorkoutCoreEntity, at idx: Int)

    @objc(removeObjectFromDayWorkoutsAtIndex:)
    @NSManaged public func removeFromDayWorkouts(at idx: Int)

    @objc(insertDayWorkouts:atIndexes:)
    @NSManaged public func insertIntoDayWorkouts(_ values: [DayWorkoutCoreEntity], at indexes: NSIndexSet)

    @objc(removeDayWorkoutsAtIndexes:)
    @NSManaged public func removeFromDayWorkouts(at indexes: NSIndexSet)

    @objc(replaceObjectInDayWorkoutsAtIndex:withObject:)
    @NSManaged public func replaceDayWorkouts(at idx: Int, with value: DayWorkoutCoreEntity)

    @objc(replaceDayWorkoutsAtIndexes:withDayWorkouts:)
    @NSManaged public func replaceDayWorkouts(at indexes: NSIndexSet, with values: [DayWorkoutCoreEntity])

    @objc(addDayWorkoutsObject:)
    @NSManaged public func addToDayWorkouts(_ value: DayWorkoutCoreEntity)

    @objc(removeDayWorkoutsObject:)
    @NSManaged public func removeFromDayWorkouts(_ value: DayWorkoutCoreEntity)

    @objc(addDayWorkouts:)
    @NSManaged public func addToDayWorkouts(_ values: NSOrderedSet)

    @objc(removeDayWorkouts:)
    @NSManaged public func removeFromDayWorkouts(_ values: NSOrderedSet)

}

extension ProgramCoreEntity : Identifiable {

}
