//
//  ExerciseUnit.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

enum ExerciseUnit: Codable {
    
    case seconds
    case minutes
    case repetitions
    
}

extension ExerciseUnit {
    
    var title: String {
        switch self {
        case .seconds:
            return "초 (Sec)" // Q: 초에 대한 기획.
        case .minutes:
            return "분 (Min)"
        case .repetitions:
            return "회 (rep)"
        }
    }
    
}
