//
//  RecentActivitiesCoreDataProvider.swift
//  TodayWod
//
//  Created by 오지연 on 10/17/24.
//

import CoreData

final class RecentWodCoreDataProvider {
    
    private let coreData: WodCoreData
    
    init(coreData: WodCoreData) {
        self.coreData = coreData
    }
    
    private var context: NSManagedObjectContext {
        self.coreData.context
    }
    
    func getRecentActivities() async throws -> [DayWorkoutModel] {
        try await context.perform {
            try self.fetchRecentActivities().map {
                DayWorkoutModel(recentCoreData: $0)
            }.reversed()
        }
    }
    
    func setRecentActivities(model: DayWorkoutModel) async throws {
        try await context.perform {
            let recentActivitiesModels = try self.removeLeastRecentActivities().map {
                DayWorkoutModel(recentCoreData: $0)
            }
            
            var currentActivitiesModel = model
            if recentActivitiesModels.contains(where: { $0.id == model.id }) { // 중복 데이터를 구분 처리.
                currentActivitiesModel.id = UUID().uuidString
            }
            
            _ = RecentActivitiesCoreEntity.instance(with: self.context, model: currentActivitiesModel)
            
            self.coreData.saveContext()
        }
    }
}

private extension RecentWodCoreDataProvider {

    func fetchRecentActivities() throws -> [RecentActivitiesCoreEntity] {
        let recentActivities = try context.fetch(self.coreData.recentActivitiesFetchRequest)
        return recentActivities
    }
    
    func removeRecentActivities() throws -> Void {
        let recentActivities = try context.fetch(self.coreData.recentActivitiesFetchRequest)

        recentActivities.forEach {
            context.delete($0)
        }

        try context.save()
    }
    
    func removeLeastRecentActivities() throws -> [RecentActivitiesCoreEntity] {
        var recentActivities = try self.fetchRecentActivities()
        
        if recentActivities.count >= 10 { // 최대 10개 저장.
            if let firstEntity = recentActivities.first {
                self.context.delete(firstEntity)
            }
            self.coreData.saveContext()
            
            recentActivities.removeFirst()
        }
        
        return recentActivities
    }

}
