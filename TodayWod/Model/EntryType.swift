//
//  EntryType.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/28/24.
//

import Foundation

enum EntryType {
    case onBoarding
    case modify
}

extension EntryType {

    var levelButtonTitle: String {
        switch self {
        case .onBoarding:
            "다음"
        case .modify:
            "확인"
        }
    }

    var methodButtonTitle: String {
        switch self {
        case .onBoarding:
            "시작하기"
        case .modify:
            "확인"
        }
    }

}
