//
//  WorkoutConfirmationType.swift
//  TodayWod
//
//  Created by 오지연 on 10/16/24.
//

enum WorkoutConfirmationType: String {
    
    case quit
    case completed
    
}

extension WorkoutConfirmationType {
    
    var title: String {
        "운동을 완료할까요?"
    }
    
    var description: String {
        switch self {
        case .quit:
            return "아직 완료하지 않은 운동이 있어요.\n체크한 운동만 기록돼요."
        case .completed:
            return "오늘의 운동을 완벽하게 끝냈어요!\n한 걸음 더 강해졌어요, 내일도 파이팅이에요!"
        }
    }
    
    var cancelButtonTitle: String {
        switch self {
        case .quit:
            return "취소"
        case .completed:
            return "조금 더 할래요"
        }
    }
    
    var doneButtonTitle: String {
        "운동 완료"
    }
    
}
