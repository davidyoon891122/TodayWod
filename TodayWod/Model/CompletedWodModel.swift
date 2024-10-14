//
//  CompletedWodModel.swift
//  TodayWod
//
//  Created by 오지연 on 10/13/24.
//

import Foundation

struct CompletedWodModel: Codable, Equatable, Identifiable {
    
    var id: UUID
    let date: Date?
    let duration: Int
    
    init(data: CompletedWodEntity) {
        self.id = UUID()
        
        self.date = data.date
        self.duration = data.duration
    }
    
}

extension CompletedWodModel {

    static let fake: Self = .init(data: CompletedWodEntity.fake)

}
