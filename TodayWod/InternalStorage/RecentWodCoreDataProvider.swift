//
//  RecentActivitiesCoreDataProvider.swift
//  TodayWod
//
//  Created by 오지연 on 10/17/24.
//

final class RecentWodCoreDataProvider {
    
    static let shared = RecentWodCoreDataProvider()
    
    private let context = RecentWodCoreData.shared.context
    
    func getRecentActivities() throws -> [DayWorkoutModel] {
        guard let recentActivitiesEntity = try self.fetchRecentActivities() else { return [] }
        let dayWorkOutEntities = recentActivitiesEntity.dayWorkouts.compactMap { $0 as? DayWorkoutCoreEntity }

        return dayWorkOutEntities.map {
            DayWorkoutModel(coreData: $0)
        }
    }
    
    func setRecentActivities(model: DayWorkoutModel) async throws {
        try await context.perform {
            var dayWorkouts: [DayWorkoutModel] = []
            
            if let currentActivityEntity = try self.fetchRecentActivities() {
                dayWorkouts = RecentActivitiesModel(coreData: currentActivityEntity).dayWorkouts
            }
            
            if dayWorkouts.count >= 3 { // 최대 3개 저장.
                dayWorkouts.removeFirst()
            }
            dayWorkouts.append(model)
            
            let recentActivities = RecentActivitiesModel(dayWorkouts: dayWorkouts)
            
            do {
                try self.removeRecentActivities()
            } catch {
                throw error
            }
            
            _ = RecentActivitiesCoreEntity.instance(with: self.context, model: recentActivities)
            
            RecentWodCoreData.shared.saveContext()
        }
    }
}

private extension RecentWodCoreDataProvider {

    func fetchRecentActivities() throws -> RecentActivitiesCoreEntity? {
        let recentActivities = try context.fetch(RecentWodCoreData.shared.fetchRecentActivities())
        return recentActivities.first
    }
    
    func removeRecentActivities() throws -> Void {
        let recentActivities = try context.fetch(RecentWodCoreData.shared.fetchRecentActivities())

        recentActivities.forEach {
            context.delete($0)
        }

        try context.save()
    }

}
