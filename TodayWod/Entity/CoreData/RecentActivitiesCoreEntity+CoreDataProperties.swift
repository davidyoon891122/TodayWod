//
//  RecentActivitiesCoreEntity+CoreDataProperties.swift
//  TodayWod
//
//  Created by 오지연 on 10/17/24.
//
//

import Foundation
import CoreData


extension RecentActivitiesCoreEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentActivitiesCoreEntity> {
        return NSFetchRequest<RecentActivitiesCoreEntity>(entityName: "RecentActivitiesCoreEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var dayWorkouts: NSOrderedSet

}

// MARK: Generated accessors for dayWorkouts
extension RecentActivitiesCoreEntity {

    @objc(insertObject:inDayWorkoutsAtIndex:)
    @NSManaged public func insertIntoDayWorkouts(_ value: NSManagedObject, at idx: Int)

    @objc(removeObjectFromDayWorkoutsAtIndex:)
    @NSManaged public func removeFromDayWorkouts(at idx: Int)

    @objc(insertDayWorkouts:atIndexes:)
    @NSManaged public func insertIntoDayWorkouts(_ values: [NSManagedObject], at indexes: NSIndexSet)

    @objc(removeDayWorkoutsAtIndexes:)
    @NSManaged public func removeFromDayWorkouts(at indexes: NSIndexSet)

    @objc(replaceObjectInDayWorkoutsAtIndex:withObject:)
    @NSManaged public func replaceDayWorkouts(at idx: Int, with value: NSManagedObject)

    @objc(replaceDayWorkoutsAtIndexes:withDayWorkouts:)
    @NSManaged public func replaceDayWorkouts(at indexes: NSIndexSet, with values: [NSManagedObject])

    @objc(addDayWorkoutsObject:)
    @NSManaged public func addToDayWorkouts(_ value: NSManagedObject)

    @objc(removeDayWorkoutsObject:)
    @NSManaged public func removeFromDayWorkouts(_ value: NSManagedObject)

    @objc(addDayWorkouts:)
    @NSManaged public func addToDayWorkouts(_ values: NSOrderedSet)

    @objc(removeDayWorkouts:)
    @NSManaged public func removeFromDayWorkouts(_ values: NSOrderedSet)

}

extension RecentActivitiesCoreEntity : Identifiable {

}
