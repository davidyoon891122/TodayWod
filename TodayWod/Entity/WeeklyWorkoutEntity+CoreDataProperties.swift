//
//  WeeklyWorkoutEntity+CoreDataProperties.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//
//

import Foundation
import CoreData


extension WeeklyWorkoutEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeeklyWorkoutEntity> {
        return NSFetchRequest<WeeklyWorkoutEntity>(entityName: "WeeklyWorkoutEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var subTitle: String
    @NSManaged public var type: String
    @NSManaged public var expectedMinutes: Int64
    @NSManaged public var maxExpectedCalories: Int64
    @NSManaged public var minExpectedCalories: Int64
    @NSManaged public var dayWorkouts: NSOrderedSet

}

// MARK: Generated accessors for dayWorkouts
extension WeeklyWorkoutEntity {

    @objc(insertObject:inDayWorkoutsAtIndex:)
    @NSManaged public func insertIntoDayWorkouts(_ value: DayWorkoutEntity, at idx: Int)

    @objc(removeObjectFromDayWorkoutsAtIndex:)
    @NSManaged public func removeFromDayWorkouts(at idx: Int)

    @objc(insertDayWorkouts:atIndexes:)
    @NSManaged public func insertIntoDayWorkouts(_ values: [DayWorkoutEntity], at indexes: NSIndexSet)

    @objc(removeDayWorkoutsAtIndexes:)
    @NSManaged public func removeFromDayWorkouts(at indexes: NSIndexSet)

    @objc(replaceObjectInDayWorkoutsAtIndex:withObject:)
    @NSManaged public func replaceDayWorkouts(at idx: Int, with value: DayWorkoutEntity)

    @objc(replaceDayWorkoutsAtIndexes:withDayWorkouts:)
    @NSManaged public func replaceDayWorkouts(at indexes: NSIndexSet, with values: [DayWorkoutEntity])

    @objc(addDayWorkoutsObject:)
    @NSManaged public func addToDayWorkouts(_ value: DayWorkoutEntity)

    @objc(removeDayWorkoutsObject:)
    @NSManaged public func removeFromDayWorkouts(_ value: DayWorkoutEntity)

    @objc(addDayWorkouts:)
    @NSManaged public func addToDayWorkouts(_ values: NSOrderedSet)

    @objc(removeDayWorkouts:)
    @NSManaged public func removeFromDayWorkouts(_ values: NSOrderedSet)

}

extension WeeklyWorkoutEntity : Identifiable {

}
