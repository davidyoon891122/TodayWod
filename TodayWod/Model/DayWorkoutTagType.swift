//
//  DayWorkoutTagType.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

enum DayWorkoutTagType: String, Codable {
    
    case start
    case end
    case `default`
    
}

extension DayWorkoutTagType {
    
    var title: String? {
        switch self {
        case .start:
            return "start"
        case .end:
            return "final"
        default:
            return nil
        }
    }
    
}
