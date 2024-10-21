//
//  CompletedDate+Entity.swift
//  TodayWod
//
//  Created by 오지연 on 10/13/24.
//
import Foundation

struct CompletedDateEntity: Codable, Equatable {
    
    let date: Date
    let duration: Int
    
}

extension CompletedDateEntity {
    
    static var fake: Self {
        .init(date: "2024-09-30".toDate() ?? Date(), duration: 120)
    }

}
