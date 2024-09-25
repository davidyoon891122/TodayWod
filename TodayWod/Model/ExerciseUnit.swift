//
//  ExerciseUnit.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

enum ExerciseUnit: Codable {
    
    case minutes
    case repetitions
    
}

extension ExerciseUnit {
    
    var title: String {
        switch self {
        case .minutes:
            return "분 (Min)"
        case .repetitions:
            return "회 (rep)"
        }
    }
    
}
