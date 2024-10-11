//
//  WorkOutType.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

enum WorkOutType: String, Codable {
    
    case warmUp
    case main
    case coolDown
    
}

extension WorkOutType {
    
    var title: String {
        switch self {
        case .warmUp:
            return "Warm-Up"
        case .main:
            return "Main WOD"
        case .coolDown:
            return "Cool Down"
        }
    }
    
}
