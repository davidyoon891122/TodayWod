//
//  WodSetEntity+CoreDataClass.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//
//

import Foundation
import CoreData

@objc(WodSetEntity)
public class WodSetEntity: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
    
}

extension WodSetEntity {

    static func createWodSetEntity(with context: NSManagedObjectContext, models: [WodSetModel]) -> [WodSetEntity] {
        return models.map { model in
            let newItem = WodSetEntity(context: context)
            newItem.id = model.id
            newItem.unitValue = Int64(model.unitValue)
            newItem.isCompleted = model.isCompleted

            return newItem
        }
    }

}
