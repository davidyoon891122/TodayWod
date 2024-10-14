//
//  DayWorkoutEntity+CoreDataProperties.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//
//

import Foundation
import CoreData


extension DayWorkoutEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayWorkoutEntity> {
        return NSFetchRequest<DayWorkoutEntity>(entityName: "WeeklyWorkoutEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var subTitle: String
    @NSManaged public var type: String
    @NSManaged public var expectedMinutes: Int64
    @NSManaged public var maxExpectedCalorie: Int64
    @NSManaged public var minExpectedCalorie: Int64
    @NSManaged public var workouts: NSOrderedSet

}

// MARK: Generated accessors for dayWorkouts
extension DayWorkoutEntity {

    @objc(insertObject:inDayWorkoutsAtIndex:)
    @NSManaged public func insertIntoDayWorkouts(_ value: WorkoutEntity, at idx: Int)

    @objc(removeObjectFromDayWorkoutsAtIndex:)
    @NSManaged public func removeFromDayWorkouts(at idx: Int)

    @objc(insertDayWorkouts:atIndexes:)
    @NSManaged public func insertIntoDayWorkouts(_ values: [WorkoutEntity], at indexes: NSIndexSet)

    @objc(removeDayWorkoutsAtIndexes:)
    @NSManaged public func removeFromDayWorkouts(at indexes: NSIndexSet)

    @objc(replaceObjectInDayWorkoutsAtIndex:withObject:)
    @NSManaged public func replaceDayWorkouts(at idx: Int, with value: WorkoutEntity)

    @objc(replaceDayWorkoutsAtIndexes:withDayWorkouts:)
    @NSManaged public func replaceDayWorkouts(at indexes: NSIndexSet, with values: [WorkoutEntity])

    @objc(addDayWorkoutsObject:)
    @NSManaged public func addToDayWorkouts(_ value: WorkoutEntity)

    @objc(removeDayWorkoutsObject:)
    @NSManaged public func removeFromDayWorkouts(_ value: WorkoutEntity)

    @objc(addDayWorkouts:)
    @NSManaged public func addToDayWorkouts(_ values: NSOrderedSet)

    @objc(removeDayWorkouts:)
    @NSManaged public func removeFromDayWorkouts(_ values: NSOrderedSet)

}

extension DayWorkoutEntity : Identifiable {

}
