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

    static func createWorkoutItemEntity(with context: NSManagedObjectContext, models: [WodModel]) -> [WodEntity] {
        models.map { model in
            let newItem = WodEntity(context: context)
            newItem.id = model.id
            newItem.title = model.title
            newItem.subTitle = model.subTitle
            newItem.unit = model.unit.rawValue
            newItem.unitValue = Int64(model.unitValue)
            newItem.set = Int64(model.set)
            let wodSet = WodSetEntity.createWodSetEntity(with: context, models: model.wodSet)
            newItem.wodSet = NSOrderedSet(array: wodSet)
            return newItem
        }
    }

    static func convertModelToEntity(with context: NSManagedObjectContext, model: WodModel) -> WodEntity {
        let newItem = WodEntity(context: context)
        newItem.id = model.id
        newItem.title = model.title
        newItem.subTitle = model.subTitle
        newItem.unit = model.unit.rawValue
        newItem.unitValue = Int64(model.unitValue)
        newItem.set = Int64(model.set)
        newItem.wodSet = NSOrderedSet(array: WodSetEntity.createWodSetEntity(with: context, models: model.wodSet))

        return newItem
    }

}
