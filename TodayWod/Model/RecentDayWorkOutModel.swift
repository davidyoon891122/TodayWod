//
//  RecentDayWorkOutModel.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/21/24.
//

import Foundation

struct RecentDayWorkOutModel: Codable, Equatable, Identifiable {

    var id: UUID
    
    let date: Date?
    let duration: Int
    let type: DayWorkOutTagType
    let title: String
    let subTitle: String
    let expectedMinute: Int
    let minEstimatedCalorie: Int
    let maxEstimatedCalorie: Int
    var workOuts: [WorkOutModel]
    
    init(data: RecentDayWorkOutEntity) {
        self.id = UUID()
        
        self.date = data.date.toDate
        self.duration = data.duration
        self.type = data.type
        self.title = data.title
        self.subTitle = data.subTitle
        self.expectedMinute = data.expectedMinute
        self.minEstimatedCalorie = data.minEstimatedCalorie
        self.maxEstimatedCalorie = data.maxEstimatedCalorie
        self.workOuts = data.workOuts.map { WorkOutModel(data: $0) }
    }

}

extension RecentDayWorkOutModel {
    
    var displayDate: String {
        date?.toString ?? ""
    }
    
}

extension RecentDayWorkOutModel {

    static let fakes: [Self] = RecentDayWorkOutEntity.fakes.map { .init(data: $0) }

}
