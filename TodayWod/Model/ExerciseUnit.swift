//
//  ExerciseUnit.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

enum ExerciseUnit: String, Codable {
    
    case seconds
    case minutes
    case repetitions
    
}

extension ExerciseUnit {
    
    var title: String {
        switch self {
        case .seconds:
            return "초" // Q: 초에 대한 기획.
        case .minutes:
            return "분"
        case .repetitions:
            return "회"
        }
    }
    
    var displayTitle: String {
        switch self {
        case .seconds:
            return self.title + " (Sec)" // Q: 초에 대한 기획.
        case .minutes:
            return self.title + " (Min)"
        case .repetitions:
            return self.title + " (rep)"
        }
    }
    
}
