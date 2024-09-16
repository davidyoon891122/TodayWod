//
//  LevelType.swift
//  TodayWod
//
//  Created by Davidyoon on 9/13/24.
//

import Foundation

enum LevelType: Codable, CaseIterable {
    
    case beginner
    case elementary
    case intermediate
    case advanced

    var title: String {
        switch self {
        case .beginner:
            "입문"
        case .elementary:
            "초급"
        case .intermediate:
            "중급"
        case .advanced:
            "고급"
        }
    }

    var description: String {
        switch self {
        case .beginner:
            "기초 운동을 배우는 것이 목표에요"
        case .elementary:
            "체력을 향상시키고 복합 운동을 시작하는 단계에요"
        case .intermediate:
            "복합적인 웨이트 리프팅을 다룰 수 있어요"
        case .advanced:
            "고난도 동작과 고중량을 다룰 수 있어요"
        }
    }

}
