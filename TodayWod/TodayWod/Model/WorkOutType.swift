//
//  WorkOutType.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

enum WorkOutType: Codable {
    
    case WarmUp
    case Main
    case CoolDown
    
}

extension WorkOutType {
    
    var title: String {
        switch self {
        case .WarmUp:
            return "Warm-Up"
        case .Main:
            return "Main WOD"
        case .CoolDown:
            return "Cool Down"
        }
    }
    
}
