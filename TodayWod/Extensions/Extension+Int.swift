//
//  Extension+Int.swift
//  TodayWod
//
//  Created by 오지연 on 9/29/24.
//

import Foundation

extension Int {
    
    var timerFormatter: String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = self % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
}
