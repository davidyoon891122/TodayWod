//
//  WodEntity+CoreDataProperties.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//
//

import Foundation
import CoreData


extension WodEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WodEntity> {
        return NSFetchRequest<WodEntity>(entityName: "WodEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var set: Int64
    @NSManaged public var subTitle: String
    @NSManaged public var title: String
    @NSManaged public var unit: String
    @NSManaged public var unitValue: Int64
    @NSManaged public var wodSets: NSOrderedSet

}

// MARK: Generated accessors for wodSet
extension WodEntity {

    @objc(insertObject:inWodSetAtIndex:)
    @NSManaged public func insertIntoWodSet(_ value: WodSetEntity, at idx: Int)

    @objc(removeObjectFromWodSetAtIndex:)
    @NSManaged public func removeFromWodSet(at idx: Int)

    @objc(insertWodSet:atIndexes:)
    @NSManaged public func insertIntoWodSet(_ values: [WodSetEntity], at indexes: NSIndexSet)

    @objc(removeWodSetAtIndexes:)
    @NSManaged public func removeFromWodSet(at indexes: NSIndexSet)

    @objc(replaceObjectInWodSetAtIndex:withObject:)
    @NSManaged public func replaceWodSet(at idx: Int, with value: WodSetEntity)

    @objc(replaceWodSetAtIndexes:withWodSet:)
    @NSManaged public func replaceWodSet(at indexes: NSIndexSet, with values: [WodSetEntity])

    @objc(addWodSetObject:)
    @NSManaged public func addToWodSet(_ value: WodSetEntity)

    @objc(removeWodSetObject:)
    @NSManaged public func removeFromWodSet(_ value: WodSetEntity)

    @objc(addWodSet:)
    @NSManaged public func addToWodSet(_ values: NSOrderedSet)

    @objc(removeWodSet:)
    @NSManaged public func removeFromWodSet(_ values: NSOrderedSet)

}

extension WodEntity : Identifiable {

}
