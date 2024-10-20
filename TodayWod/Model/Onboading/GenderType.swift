//
//  GenderType.swift
//  TodayWod
//
//  Created by Davidyoon on 9/13/24.
//

import Foundation

enum GenderType: Codable {
    
    case man
    case woman
    
    var title: String {
        switch self {
        case .man:
            "남성"
        case .woman:
            "여성"
        }
    }
    
}
