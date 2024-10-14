//
//  CompletedWod+Entity.swift
//  TodayWod
//
//  Created by 오지연 on 10/13/24.
//
import Foundation

struct CompletedWodEntity: Codable, Equatable {
    
    let date: Date?
    let duration: Int
    
}

extension CompletedWodEntity {
    
    static var fake: Self {
        .init(date: "2024-09-30".toDate(), duration: 120)
    }

}
