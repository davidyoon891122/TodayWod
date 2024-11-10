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
    
    func getCompletedDates() async throws -> [CompletedDateModel] {
        try await context.perform {
            try self.fetchCompletedDates().map {
                CompletedDateModel(coreData: $0)
            }
        }
    }
    
    func setCompletedDates(model: CompletedDateModel) async throws {
        await context.perform {
            _ = CompletedDayWorkoutCoreEntity.instance(with: self.context, model: model)
            
            self.coreData.saveContext()
        }
    }
}

private extension CompletedWodCoreDataProvider {

    func fetchCompletedDates() throws -> [CompletedDayWorkoutCoreEntity] {
        let completedDates = try context.fetch(self.coreData.completedDayWorkoutFetchRequest)
        return completedDates
    }
    
    func removeCompletedDates() throws -> Void {
        let completedDates = try context.fetch(self.coreData.completedDayWorkoutFetchRequest)

        completedDates.forEach {
            context.delete($0)
        }

        try context.save()
    }

}
