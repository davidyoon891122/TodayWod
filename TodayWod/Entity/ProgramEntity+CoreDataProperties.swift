//
//  ProgramsEntity+CoreDataProperties.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//
//

import Foundation
import CoreData


extension ProgramEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProgramEntity> {
        return NSFetchRequest<ProgramEntity>(entityName: "ProgramsEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var level: String
    @NSManaged public var methodType: String
    @NSManaged public var dayWorkouts: NSOrderedSet

}

// MARK: Generated accessors for weeklyWorkouts
extension ProgramEntity {

    @objc(insertObject:inWeeklyWorkoutsAtIndex:)
    @NSManaged public func insertIntoWeeklyWorkouts(_ value: DayWorkoutEntity, at idx: Int)

    @objc(removeObjectFromWeeklyWorkoutsAtIndex:)
    @NSManaged public func removeFromWeeklyWorkouts(at idx: Int)

    @objc(insertWeeklyWorkouts:atIndexes:)
    @NSManaged public func insertIntoWeeklyWorkouts(_ values: [DayWorkoutEntity], at indexes: NSIndexSet)

    @objc(removeWeeklyWorkoutsAtIndexes:)
    @NSManaged public func removeFromWeeklyWorkouts(at indexes: NSIndexSet)

    @objc(replaceObjectInWeeklyWorkoutsAtIndex:withObject:)
    @NSManaged public func replaceWeeklyWorkouts(at idx: Int, with value: DayWorkoutEntity)

    @objc(replaceWeeklyWorkoutsAtIndexes:withWeeklyWorkouts:)
    @NSManaged public func replaceWeeklyWorkouts(at indexes: NSIndexSet, with values: [DayWorkoutEntity])

    @objc(addWeeklyWorkoutsObject:)
    @NSManaged public func addToWeeklyWorkouts(_ value: DayWorkoutEntity)

    @objc(removeWeeklyWorkoutsObject:)
    @NSManaged public func removeFromWeeklyWorkouts(_ value: DayWorkoutEntity)

    @objc(addWeeklyWorkouts:)
    @NSManaged public func addToWeeklyWorkouts(_ values: NSOrderedSet)

    @objc(removeWeeklyWorkouts:)
    @NSManaged public func removeFromWeeklyWorkouts(_ values: NSOrderedSet)

}

extension ProgramEntity : Identifiable {

}
