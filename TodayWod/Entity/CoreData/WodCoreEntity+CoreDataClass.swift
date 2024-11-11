//
//  WodCoreEntity+CoreDataClass.swift
//  TodayWod
//
//  Created by D프로젝트노드_오지연 on 10/15/24.
//
//

import Foundation
import CoreData

@objc(WodCoreEntity)
public class WodCoreEntity: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
    
}

extension WodCoreEntity {

    static func createWorkoutItemEntity(with context: NSManagedObjectContext, models: [WodModel]) -> [WodCoreEntity] {
        models.map { model in
            let newItem = WodCoreEntity(context: context)
            newItem.id = model.id
            newItem.title = model.title
            newItem.subTitle = model.subTitle
            newItem.unit = model.unit.rawValue
            newItem.unitValue = Int64(model.unitValue)
            newItem.set = Int64(model.set)
            let wodSets = WodSetCoreEntity.createWodSetEntity(with: context, models: model.wodSets)
            newItem.wodSets = NSOrderedSet(array: wodSets)
            newItem.expectedCalorie = Int64(model.expectedCalorie)
            return newItem
        }
    }

    static func convertModelToEntity(with context: NSManagedObjectContext, model: WodModel) -> WodCoreEntity {
        let newItem = WodCoreEntity(context: context)
        newItem.id = model.id
        newItem.title = model.title
        newItem.subTitle = model.subTitle
        newItem.unit = model.unit.rawValue
        newItem.unitValue = Int64(model.unitValue)
        newItem.set = Int64(model.set)
        newItem.wodSets = NSOrderedSet(array: WodSetCoreEntity.createWodSetEntity(with: context, models: model.wodSets))

        return newItem
    }

}
