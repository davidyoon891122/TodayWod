//
//  Extension+Array.swift
//  TodayWod
//
//  Created by 오지연 on 9/29/24.
//

import Foundation

extension Array {
    
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
}
