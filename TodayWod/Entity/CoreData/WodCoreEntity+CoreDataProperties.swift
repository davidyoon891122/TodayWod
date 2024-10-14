//
//  WodCoreEntity+CoreDataProperties.swift
//  TodayWod
//
//  Created by D프로젝트노드_오지연 on 10/15/24.
//
//

import Foundation
import CoreData


extension WodCoreEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WodCoreEntity> {
        return NSFetchRequest<WodCoreEntity>(entityName: "WodCoreEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var set: Int64
    @NSManaged public var subTitle: String
    @NSManaged public var title: String
    @NSManaged public var unit: String
    @NSManaged public var unitValue: Int64
    @NSManaged public var workoutId: UUID
    @NSManaged public var wodSets: NSOrderedSet

}

// MARK: Generated accessors for wodSets
extension WodCoreEntity {

    @objc(insertObject:inWodSetsAtIndex:)
    @NSManaged public func insertIntoWodSets(_ value: WodSetCoreEntity, at idx: Int)

    @objc(removeObjectFromWodSetsAtIndex:)
    @NSManaged public func removeFromWodSets(at idx: Int)

    @objc(insertWodSets:atIndexes:)
    @NSManaged public func insertIntoWodSets(_ values: [WodSetCoreEntity], at indexes: NSIndexSet)

    @objc(removeWodSetsAtIndexes:)
    @NSManaged public func removeFromWodSets(at indexes: NSIndexSet)

    @objc(replaceObjectInWodSetsAtIndex:withObject:)
    @NSManaged public func replaceWodSets(at idx: Int, with value: WodSetCoreEntity)

    @objc(replaceWodSetsAtIndexes:withWodSets:)
    @NSManaged public func replaceWodSets(at indexes: NSIndexSet, with values: [WodSetCoreEntity])

    @objc(addWodSetsObject:)
    @NSManaged public func addToWodSets(_ value: WodSetCoreEntity)

    @objc(removeWodSetsObject:)
    @NSManaged public func removeFromWodSets(_ value: WodSetCoreEntity)

    @objc(addWodSets:)
    @NSManaged public func addToWodSets(_ values: NSOrderedSet)

    @objc(removeWodSets:)
    @NSManaged public func removeFromWodSets(_ values: NSOrderedSet)

}

extension WodCoreEntity : Identifiable {

}
