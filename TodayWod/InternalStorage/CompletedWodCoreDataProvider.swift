//
//  CompletedWodCoreDataProvider.swift
//  TodayWod
//
//  Created by 오지연 on 10/21/24.
//
import CoreData

final class CompletedWodCoreDataProvider {
    
    private let coreData: WodCoreData
    
    init(coreData: WodCoreData) {
        self.coreData = coreData
    }
    
    private var context: NSManagedObjectContext {
        self.coreData.context
    }
    
    func getCompletedDates() throws -> [CompletedDayWorkoutModel] {
        guard let recentActivitiesEntity = try self.fetchRecentActivities() else { return [] }
        let dayWorkOutEntities = recentActivitiesEntity.dayWorkouts.compactMap { $0 as? DayWorkoutCoreEntity }

        return dayWorkOutEntities.map {
            DayWorkoutModel(coreData: $0)
        }
    }
    
    func setCompletedDates(model: CompletedDayWorkoutModel) async throws {
        try await context.perform {
            var dayWorkouts: [DayWorkoutModel] = []
            
            if let currentActivityEntity = try self.fetchRecentActivities() {
                dayWorkouts = RecentActivitiesModel(coreData: currentActivityEntity).dayWorkouts
            }
            
            if dayWorkouts.count >= 3 { // 최대 3개 저장.
                dayWorkouts.removeLast()
            }
            
            var updatedModel = model
            if dayWorkouts.contains(where: { $0.id == model.id }) { // 중복 데이터를 구분 처리.
                updatedModel.id = UUID()
            }
            dayWorkouts.insert(updatedModel, at: 0)
            
            let recentActivities = RecentActivitiesModel(dayWorkouts: dayWorkouts)
            
            do {
                try self.removeRecentActivities()
            } catch {
                throw error
            }
            
            _ = RecentActivitiesCoreEntity.instance(with: self.context, model: recentActivities)
            
            self.coreData.saveContext()
        }
    }
}

private extension CompletedWodCoreDataProvider {

    func fetchCompletedDate() throws -> CompletedDayWorkoutCoreEntity? {
        let completedDates = try context.fetch(self.coreData.completedDayWorkoutFetchRequest)
        return completedDates.first
    }
    
    func removeCompletedDates() throws -> Void {
        let completedDates = try context.fetch(self.coreData.completedDayWorkoutFetchRequest)

        completedDates.forEach {
            context.delete($0)
        }

        try context.save()
    }

}
