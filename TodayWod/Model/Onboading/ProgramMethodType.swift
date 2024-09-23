//
//  ProgramMethodType.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/16/24.
//

import Foundation

enum ProgramMethodType: Codable {
    case body
    case machine

    var title: String {
        switch self {
        case .body:
            "맨몸 위주 운동"
        case .machine:
            "머신 위주 운동"
        }
    }

    var description: String {
        switch self {
        case .body:
            """
            초보자부터 고급자까지 누구나 수행할 수 있는 운동이에요. 전신의 근력을 강화할 뿐만 아니라, 유연성, 균형 감각, 심폐 지구력 등 다양한 신체 기능을 종합적으로 향상시킬 수 있어요.
            \n
            맨몸 운동은 부상 위험이 낮으며, 체력 수준에 맞게 난이도를 조절할 수 있어 꾸준한 운동 습관을 들이기에도 좋아요.
            """
        case .machine:
            """
            다양한 헬스장 기구와 머신을 이용해 근육을 자극하는 운동이에요.
            \n
            안정적인 근력 운동을 원하는 사람들에게 적합하며, 기구의 안전장치를 통해 고중량 운동을 안전하게 수행할 수 있어 근력 향상을 목표로 하는 사람들에게 이상적이에요. 부상 위험이 적어 경험이 적은 사용자에게도 좋아요.
            """
        }
    }
}
