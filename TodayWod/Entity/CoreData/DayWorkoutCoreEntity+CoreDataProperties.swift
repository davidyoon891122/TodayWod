//
//  DayWorkoutCoreEntity+CoreDataProperties.swift
//  TodayWod
//
//  Created by 오지연 on 10/15/24.
//
//

import Foundation
import CoreData


extension DayWorkoutCoreEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayWorkoutCoreEntity> {
        return NSFetchRequest<DayWorkoutCoreEntity>(entityName: "DayWorkoutCoreEntity")
    }

    @NSManaged public var expectedMinute: Int64
    @NSManaged public var id: String
    @NSManaged public var maxExpectedCalorie: Int64
    @NSManaged public var minExpectedCalorie: Int64
    @NSManaged public var subTitle: String
    @NSManaged public var title: String
    @NSManaged public var type: String
    @NSManaged public var date: Date?
    @NSManaged public var duration: Int64
    @NSManaged public var workouts: NSOrderedSet
    @NSManaged public var imageName: String

}

// MARK: Generated accessors for workouts
extension DayWorkoutCoreEntity {

    @objc(insertObject:inWorkoutsAtIndex:)
    @NSManaged public func insertIntoWorkouts(_ value: WorkoutCoreEntity, at idx: Int)

    @objc(removeObjectFromWorkoutsAtIndex:)
    @NSManaged public func removeFromWorkouts(at idx: Int)

    @objc(insertWorkouts:atIndexes:)
    @NSManaged public func insertIntoWorkouts(_ values: [WorkoutCoreEntity], at indexes: NSIndexSet)

    @objc(removeWorkoutsAtIndexes:)
    @NSManaged public func removeFromWorkouts(at indexes: NSIndexSet)

    @objc(replaceObjectInWorkoutsAtIndex:withObject:)
    @NSManaged public func replaceWorkouts(at idx: Int, with value: WorkoutCoreEntity)

    @objc(replaceWorkoutsAtIndexes:withWorkouts:)
    @NSManaged public func replaceWorkouts(at indexes: NSIndexSet, with values: [WorkoutCoreEntity])

    @objc(addWorkoutsObject:)
    @NSManaged public func addToWorkouts(_ value: WorkoutCoreEntity)

    @objc(removeWorkoutsObject:)
    @NSManaged public func removeFromWorkouts(_ value: WorkoutCoreEntity)

    @objc(addWorkouts:)
    @NSManaged public func addToWorkouts(_ values: NSOrderedSet)

    @objc(removeWorkouts:)
    @NSManaged public func removeFromWorkouts(_ values: NSOrderedSet)

}

extension DayWorkoutCoreEntity : Identifiable {

}
