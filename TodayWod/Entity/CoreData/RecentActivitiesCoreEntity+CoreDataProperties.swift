//
//  RecentActivitiesCoreEntity+CoreDataProperties.swift
//
//
//  Created by 오지연 on 11/11/24.
//
//

import Foundation
import CoreData

extension RecentActivitiesCoreEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentActivitiesCoreEntity> {
        return NSFetchRequest<RecentActivitiesCoreEntity>(entityName: "RecentActivitiesCoreEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var duration: Int64
    @NSManaged public var expectedMinute: Int64
    @NSManaged public var id: String
    @NSManaged public var imageName: String
    @NSManaged public var maxExpectedCalorie: Int64
    @NSManaged public var minExpectedCalorie: Int64
    @NSManaged public var subTitle: String
    @NSManaged public var title: String
    @NSManaged public var type: String
    @NSManaged public var workouts: NSOrderedSet

}

// MARK: Generated accessors for workouts
extension RecentActivitiesCoreEntity {

    @objc(insertObject:inWorkoutsAtIndex:)
    @NSManaged public func insertIntoWorkouts(_ value: RecentActivitiesCoreEntity, at idx: Int)

    @objc(removeObjectFromWorkoutsAtIndex:)
    @NSManaged public func removeFromWorkouts(at idx: Int)

    @objc(insertWorkouts:atIndexes:)
    @NSManaged public func insertIntoWorkouts(_ values: [RecentActivitiesCoreEntity], at indexes: NSIndexSet)

    @objc(removeWorkoutsAtIndexes:)
    @NSManaged public func removeFromWorkouts(at indexes: NSIndexSet)

    @objc(replaceObjectInWorkoutsAtIndex:withObject:)
    @NSManaged public func replaceWorkouts(at idx: Int, with value: RecentActivitiesCoreEntity)

    @objc(replaceWorkoutsAtIndexes:withWorkouts:)
    @NSManaged public func replaceWorkouts(at indexes: NSIndexSet, with values: [RecentActivitiesCoreEntity])

    @objc(addWorkoutsObject:)
    @NSManaged public func addToWorkouts(_ value: RecentActivitiesCoreEntity)

    @objc(removeWorkoutsObject:)
    @NSManaged public func removeFromWorkouts(_ value: RecentActivitiesCoreEntity)

    @objc(addWorkouts:)
    @NSManaged public func addToWorkouts(_ values: NSOrderedSet)

    @objc(removeWorkouts:)
    @NSManaged public func removeFromWorkouts(_ values: NSOrderedSet)

}
