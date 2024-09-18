//
//  WorkOutDayTagType.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation

enum WorkOutDayTagType: Codable {
    
    case start
    case end
    case `default`
    
}

extension WorkOutDayTagType {
    
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
