//
//  WodCoreData.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//

import Foundation
import CoreData

final class WodCoreData {
    
    static let shared = WodCoreData()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodayWodCoreData")
        
        container.loadPersistentStores(completionHandler: { _, error in
            
            if let error = error as NSError? {
                print("Load store error: \(error)")
            }
            
        })
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func saveContext() {
        if self.context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error on the WodCoreData: \(error.localizedDescription)")
            }
        }
    }
    
}

extension WodCoreData {
    
    func fetchProgram() -> NSFetchRequest<ProgramEntity> {
        let request = NSFetchRequest<ProgramEntity>(entityName: "ProgramEntity")

        return request
    }
    
}
