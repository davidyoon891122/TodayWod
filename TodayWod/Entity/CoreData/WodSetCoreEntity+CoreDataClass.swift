//
//  WodSetCoreEntity+CoreDataClass.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//
//

import Foundation
import CoreData

@objc(WodSetCoreEntity)
public class WodSetCoreEntity: NSManagedObject {

}

extension WodSetCoreEntity {

    static func createWodSetEntity(with context: NSManagedObjectContext, models: [WodSetModel]) -> [WodSetCoreEntity] {
        return models.map { model in
            let newItem = WodSetCoreEntity(context: context)
            newItem.id = model.id
            newItem.order = Int64(model.order)
            newItem.unitValue = Int64(model.unitValue)
            newItem.isCompleted = model.isCompleted

            return newItem
        }
    }

}
