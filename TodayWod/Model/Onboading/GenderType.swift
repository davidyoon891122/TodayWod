//
//  GenderType.swift
//  TodayWod
//
//  Created by Davidyoon on 9/13/24.
//

import Foundation

enum GenderType: String, Codable {
    
    case man = "man"
    case woman = "woman"
    
    var title: String {
        switch self {
        case .man:
            "남성"
        case .woman:
            "여성"
        }
    }
    
}
