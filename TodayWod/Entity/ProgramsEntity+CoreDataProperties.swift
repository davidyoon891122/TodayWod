//
//  ProgramsEntity+CoreDataProperties.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//
//

import Foundation
import CoreData


extension ProgramsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProgramsEntity> {
        return NSFetchRequest<ProgramsEntity>(entityName: "ProgramsEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var level: String
    @NSManaged public var methodType: String
    @NSManaged public var weeklyWorkouts: NSOrderedSet

}

// MARK: Generated accessors for weeklyWorkouts
extension ProgramsEntity {

    @objc(insertObject:inWeeklyWorkoutsAtIndex:)
    @NSManaged public func insertIntoWeeklyWorkouts(_ value: WeeklyWorkoutEntity, at idx: Int)

    @objc(removeObjectFromWeeklyWorkoutsAtIndex:)
    @NSManaged public func removeFromWeeklyWorkouts(at idx: Int)

    @objc(insertWeeklyWorkouts:atIndexes:)
    @NSManaged public func insertIntoWeeklyWorkouts(_ values: [WeeklyWorkoutEntity], at indexes: NSIndexSet)

    @objc(removeWeeklyWorkoutsAtIndexes:)
    @NSManaged public func removeFromWeeklyWorkouts(at indexes: NSIndexSet)

    @objc(replaceObjectInWeeklyWorkoutsAtIndex:withObject:)
    @NSManaged public func replaceWeeklyWorkouts(at idx: Int, with value: WeeklyWorkoutEntity)

    @objc(replaceWeeklyWorkoutsAtIndexes:withWeeklyWorkouts:)
    @NSManaged public func replaceWeeklyWorkouts(at indexes: NSIndexSet, with values: [WeeklyWorkoutEntity])

    @objc(addWeeklyWorkoutsObject:)
    @NSManaged public func addToWeeklyWorkouts(_ value: WeeklyWorkoutEntity)

    @objc(removeWeeklyWorkoutsObject:)
    @NSManaged public func removeFromWeeklyWorkouts(_ value: WeeklyWorkoutEntity)

    @objc(addWeeklyWorkouts:)
    @NSManaged public func addToWeeklyWorkouts(_ values: NSOrderedSet)

    @objc(removeWeeklyWorkouts:)
    @NSManaged public func removeFromWeeklyWorkouts(_ values: NSOrderedSet)

}

extension ProgramsEntity : Identifiable {

}
