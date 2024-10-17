//
//  RecentWodCoreData.swift
//  TodayWod
//
//  Created by 오지연 on 10/17/24.
//

import Foundation
import CoreData

final class RecentWodCoreData {
    
    static let shared = RecentWodCoreData()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RecentWodCoreData")
        
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

extension RecentWodCoreData {
    
    func fetchRecentActivities() -> NSFetchRequest<RecentActivitiesCoreEntity> {
        let request = NSFetchRequest<RecentActivitiesCoreEntity>(entityName: "RecentActivitiesCoreEntity")

        return request
    }
    
}
