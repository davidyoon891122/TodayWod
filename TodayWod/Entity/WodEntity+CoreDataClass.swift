//
//  WodEntity+CoreDataClass.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//
//

import Foundation
import CoreData

@objc(WodEntity)
public class WodEntity: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
    
}

extension WodEntity {

    static func createWorkoutItemEntity(with context: NSManagedObjectContext, models: [TobeWodModel]) -> [WodEntity] {
        models.map { model in
            let newItem = WodEntity(context: context)
            newItem.id = model.id
            newItem.title = model.title
            newItem.subTitle = model.subTitle
            newItem.unit = model.unit.rawValue
            newItem.unitValue = Int64(model.unitValue)
            newItem.set = Int64(model.set)
            let wodSets = WodSetEntity.createWodSetEntity(with: context, models: model.wodSets)
            newItem.wodSets = NSOrderedSet(array: wodSets)
            return newItem
        }
    }

    static func convertModelToEntity(with context: NSManagedObjectContext, model: TobeWodModel) -> WodEntity {
        let newItem = WodEntity(context: context)
        newItem.id = model.id
        newItem.title = model.title
        newItem.subTitle = model.subTitle
        newItem.unit = model.unit.rawValue
        newItem.unitValue = Int64(model.unitValue)
        newItem.set = Int64(model.set)
        newItem.wodSets = NSOrderedSet(array: WodSetEntity.createWodSetEntity(with: context, models: model.wodSets))

        return newItem
    }

}
