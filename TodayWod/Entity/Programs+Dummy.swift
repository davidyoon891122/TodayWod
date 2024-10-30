//
//  Programs+Dummy.swift
//  TodayWod
//
//  Created by 오지연 on 9/29/24.
//

import Foundation

extension ProgramEntity {
    
    static var bodyBeginner: Self {
        .init(id: UUID().uuidString, methodType: .body, level: .beginner, dayWorkouts: DayWorkoutEntity.bodyBeginnerAlphaWeek)
    }
    
    static let bodyBeginners: [Self] = [
        .init(id: UUID().uuidString, methodType: .body, level: .beginner, dayWorkouts: DayWorkoutEntity.bodyBeginnerAlphaWeek),
        .init(id: UUID().uuidString, methodType: .body, level: .beginner, dayWorkouts: DayWorkoutEntity.bodyBeginnerBetaWeek),
        .init(id: UUID().uuidString, methodType: .body, level: .beginner, dayWorkouts: DayWorkoutEntity.bodyBeginnerCharlieWeek)
    ]
    
}

extension DayWorkoutEntity {
    
    static let bodyBeginnerAlphaWeek: [Self] = [
        .init(type: .start, title: "상체 근력", subTitle: "Upper Body Strength", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerAlphaDay1Info),
        .init(type: .default, title: "하체 근력", subTitle: "Lower Body Strength", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerAlphaDay2Info),
        .init(type: .default, title: "코어 강화", subTitle: "Core Strength", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerAlphaDay3Info),
        .init(type: .default, title: "전신 운동", subTitle: "Full Body Conditioning", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerAlphaDay4Info),
        .init(type: .default, title: "상체 지구력", subTitle: "Upper Body Endurance", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerAlphaDay5Info),
        .init(type: .end, title: "하체 지구력", subTitle: "Lower Body Endurance", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerAlphaDay6Info)
    ]
    
    static let bodyBeginnerBetaWeek: [Self] = [
        .init(type: .start, title: "전신 근력", subTitle: "Full Body Strength", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerBetaDay1Info),
        .init(type: .default, title: "하체 근력", subTitle: "Lower Body Strength", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerBetaDay2Info),
        .init(type: .default, title: "코어 및 상체 근력", subTitle: "Core and Upper Body Strength", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerBetaDay3Info),
        .init(type: .default, title: "전신 지구력", subTitle: "Full Body Endurance", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerBetaDay4Info),
        .init(type: .default, title: "하체 지구력", subTitle: "Lower Body Endurance", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerBetaDay5Info),
        .init(type: .end, title: "상체 지구력", subTitle: "Upper Body Endurance", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerBetaDay6Info)
    ]
    
    static let bodyBeginnerCharlieWeek: [Self] = [
        .init(type: .start, title: "상체 지구력", subTitle: "Upper Body Endurance", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerCharlieDay1Info),
        .init(type: .default, title: "하체 근력", subTitle: "Lower Body Strength", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerCharlieDay2Info),
        .init(type: .default, title: "전신 지구력", subTitle: "Full Body Endurance", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerCharlieDay3Info),
        .init(type: .default, title: "코어 및 상체 근력", subTitle: "Core and Upper Body Strength", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerCharlieDay4Info),
        .init(type: .default, title: "하체 지구력", subTitle: "Lower Body Endurance", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerCharlieDay5Info),
        .init(type: .end, title: "전신 근력", subTitle: "Full Body Strength", expectedMinute: 60, minExpectedCalorie: 400, maxExpectedCalorie: 500, workouts: WorkoutEntity.bodyBeginnerCharlieDay6Info)
    ]
    
}

extension WorkoutEntity {
    
    //MARK: - Alpha
    static let bodyBeginnerAlphaDay1Info: [Self] = [
        .init(type: .warmUp, wods: [WodEntity.warmUp1, WodEntity.warmUp2]),
        .init(type: .main, wods: [WodEntity.main1, WodEntity.main2, WodEntity.main3]),
        .init(type: .coolDown, wods: [WodEntity.coolDown1, WodEntity.coolDown2])
    ]
    
    static let bodyBeginnerAlphaDay2Info: [Self] = [
        .init(type: .warmUp, wods: [WodEntity.warmUp3, WodEntity.warmUp4]),
        .init(type: .main, wods: [WodEntity.main4, WodEntity.main5, WodEntity.main6]),
        .init(type: .coolDown, wods: [WodEntity.coolDown3, WodEntity.coolDown4])
    ]
    
    static let bodyBeginnerAlphaDay3Info: [Self] = [
        .init(type: .warmUp, wods: [WodEntity.warmUp1, WodEntity.warmUp5]),
        .init(type: .main, wods: [WodEntity.main7, WodEntity.main8, WodEntity.main9]),
        .init(type: .coolDown, wods: [WodEntity.coolDown5, WodEntity.coolDown6])
    ]
    
    static let bodyBeginnerAlphaDay4Info: [Self] = [
        .init(type: .warmUp, wods: [WodEntity.warmUp2, WodEntity.warmUp6]),
        .init(type: .main, wods: [WodEntity.main10, WodEntity.main1, WodEntity.main3]),
        .init(type: .coolDown, wods: [WodEntity.coolDown1, WodEntity.coolDown2])
    ]
    
    static let bodyBeginnerAlphaDay5Info: [Self] = [
        .init(type: .warmUp, wods: [WodEntity.warmUp7, WodEntity.warmUp1]),
        .init(type: .main, wods: [WodEntity.main11, WodEntity.main2, WodEntity.main12]),
        .init(type: .coolDown, wods: [WodEntity.coolDown1, WodEntity.coolDown7])
    ]
    
    static let bodyBeginnerAlphaDay6Info: [Self] = [
        .init(type: .warmUp, wods: [WodEntity.warmUp3, WodEntity.warmUp2]),
        .init(type: .main, wods: [WodEntity.main13, WodEntity.main5, WodEntity.main6]),
        .init(type: .coolDown, wods: [WodEntity.coolDown4, WodEntity.coolDown2])
    ]
    
    //MARK: - Beta
    static let bodyBeginnerBetaDay1Info: [Self] = [
        .init(type: .warmUp, wods: [WodEntity.warmUp4, WodEntity.warmUp3]),
        .init(type: .main, wods: [WodEntity.main4, WodEntity.main10, WodEntity.main3]),
        .init(type: .coolDown, wods: [WodEntity.coolDown2, WodEntity.coolDown1])
    ]
    
    static let bodyBeginnerBetaDay2Info: [Self] = [
        .init(type: .warmUp, wods:  [WodEntity.warmUp2, WodEntity.warmUp1]),
        .init(type: .main, wods: [WodEntity.main6, WodEntity.main13, WodEntity.main5]),
        .init(type: .coolDown, wods: [WodEntity.coolDown4, WodEntity.coolDown3])
    ]
    
    static let bodyBeginnerBetaDay3Info: [Self] = [
        .init(type: .warmUp, wods: [WodEntity.warmUp1, WodEntity.warmUp5]),
        .init(type: .main, wods: [WodEntity.main11, WodEntity.main2, WodEntity.main9]),
        .init(type: .coolDown, wods: [WodEntity.coolDown5, WodEntity.coolDown1])
    ]
    
    static let bodyBeginnerBetaDay4Info: [Self] = [
        .init(type: .warmUp, wods: [WodEntity.warmUp2, WodEntity.warmUp6]),
        .init(type: .main, wods: [WodEntity.main14, WodEntity.main1, WodEntity.main15]),
        .init(type: .coolDown, wods: [WodEntity.coolDown2, WodEntity.coolDown7])
    ]
    
    static let bodyBeginnerBetaDay5Info: [Self] = [
        .init(type: .warmUp, wods: [WodEntity.warmUp3, WodEntity.warmUp1]),
        .init(type: .main, wods: [WodEntity.main5, WodEntity.main13, WodEntity.main16]),
        .init(type: .coolDown, wods:  [WodEntity.coolDown1, WodEntity.coolDown4])
    ]
    
    static let bodyBeginnerBetaDay6Info: [Self] = [
        .init(type: .warmUp, wods: [WodEntity.warmUp7, WodEntity.warmUp8]),
        .init(type: .main, wods: [WodEntity.main11, WodEntity.main12, WodEntity.main2]),
        .init(type: .coolDown, wods: [WodEntity.coolDown7, WodEntity.coolDown1])
    ]
    
    //MARK: - Charlie
    static let bodyBeginnerCharlieDay1Info: [Self] = [
        .init(type: .warmUp, wods: [WodEntity.warmUp1, WodEntity.warmUp2, WodEntity.warmUp9]),
        .init(type: .main, wods: [WodEntity.main11, WodEntity.main2, WodEntity.main12]),
        .init(type: .coolDown, wods: [WodEntity.coolDown1, WodEntity.coolDown8])
    ]
    
    static let bodyBeginnerCharlieDay2Info: [Self] = [
        .init(type: .warmUp, wods: [WodEntity.warmUp4, WodEntity.warmUp3]),
        .init(type: .main, wods: [WodEntity.main4, WodEntity.main5, WodEntity.main3, WodEntity.main16]),
        .init(type: .coolDown, wods: [WodEntity.coolDown3, WodEntity.coolDown9])
    ]
    
    static let bodyBeginnerCharlieDay3Info: [Self] = [
        .init(type: .warmUp, wods: [WodEntity.warmUp2, WodEntity.warmUp6]),
        .init(type: .main, wods: [WodEntity.main10, WodEntity.main1, WodEntity.main15]),
        .init(type: .coolDown, wods: [WodEntity.coolDown8, WodEntity.coolDown9])
    ]
    
    static let bodyBeginnerCharlieDay4Info: [Self] = [
        .init(type: .warmUp, wods: [WodEntity.warmUp7, WodEntity.warmUp1]),
        .init(type: .main, wods: [WodEntity.main7, WodEntity.main11, WodEntity.main9]),
        .init(type: .coolDown, wods: [WodEntity.coolDown1, WodEntity.coolDown2])
    ]
    
    static let bodyBeginnerCharlieDay5Info: [Self] = [
        .init(type: .warmUp, wods: [WodEntity.warmUp3, WodEntity.warmUp5]),
        .init(type: .main, wods: [WodEntity.main13, WodEntity.main6, WodEntity.main5]),
        .init(type: .coolDown, wods: [WodEntity.coolDown4, WodEntity.coolDown3])
    ]
    
    static let bodyBeginnerCharlieDay6Info: [Self] = [
        .init(type: .warmUp, wods: [WodEntity.warmUp2, WodEntity.warmUp1]),
        .init(type: .main, wods: [WodEntity.main14, WodEntity.main1, WodEntity.main3]),
        .init(type: .coolDown, wods: [WodEntity.coolDown1, WodEntity.coolDown10])
    ]
}

extension WodEntity {
    //MARK: - Warm Up
    static let warmUp1: Self = .init(title: "암서클", subTitle: "lowing abc", unit: .minutes, unitValue: 2, set: nil, wodSets: nil)
    static let warmUp2: Self = .init(title: "점핑잭", subTitle: "lowing abc", unit: .minutes, unitValue: 2, set: nil, wodSets: nil)
    static let warmUp3: Self = .init(title: "에어 스쿼트", subTitle: "lowing abc", unit: .minutes, unitValue: 2, set: nil, wodSets: nil)
    static let warmUp4: Self = .init(title: "인치웜 스트레치", subTitle: "lowing abc", unit: .minutes, unitValue: 2, set: nil, wodSets: nil)
    static let warmUp5: Self = .init(title: "버피", subTitle: "lowing abc", unit: .minutes, unitValue: 2, set: nil, wodSets: nil)
    static let warmUp6: Self = .init(title: "케틀벨 스윙", subTitle: "lowing abc", unit: .minutes, unitValue: 2, set: nil, wodSets: nil)
    static let warmUp7: Self = .init(title: "푸쉬업", subTitle: "lowing abc", unit: .minutes, unitValue: 2, set: nil, wodSets: nil)
    static let warmUp8: Self = .init(title: "햄스트링 스트레치", subTitle: "lowing abc", unit: .minutes, unitValue: 2, set: nil, wodSets: nil)
    static let warmUp9: Self = .init(title: "러닝", subTitle: "lowing abc", unit: .minutes, unitValue: 2, set: nil, wodSets: nil)
    
    //MARK: - main WOD
    static let main1: Self = .init(title: "덤밸 스내치", subTitle: "lowing abc", unit: .repetitions, unitValue: 8, set: 3, wodSets: (0..<3).map { .init(order: $0, unitValue: 8, isCompleted: false) })
    static let main2: Self = .init(title: "핸드 릴리즈 푸시업", subTitle: "lowing abc", unit: .repetitions, unitValue: 10, set: 3, wodSets: (0..<3).map { .init(order: $0, unitValue: 10, isCompleted: false) })
    static let main3: Self = .init(title: "박스 점프", subTitle: "lowing abc", unit: .repetitions, unitValue: 8, set: 3, wodSets: (0..<3).map { .init(order: $0, unitValue: 8, isCompleted: false) })
    static let main4: Self = .init(title: "데드리프트", subTitle: "lowing abc", unit: .repetitions, unitValue: 8, set: 3, wodSets: (0..<3).map { .init(order: $0, unitValue: 8, isCompleted: false) })
    static let main5: Self = .init(title: "런지", subTitle: "lowing abc", unit: .repetitions, unitValue: 10, set: 3, wodSets: (0..<3).map { .init(order: $0, unitValue: 10, isCompleted: false) })
    static let main6: Self = .init(title: "싱글 레그 데드리프트", subTitle: "lowing abc", unit: .repetitions, unitValue: 8, set: 3, wodSets: (0..<3).map { .init(order: $0, unitValue: 8, isCompleted: false) })
    static let main7: Self = .init(title: "플랭크", subTitle: "lowing abc", unit: .minutes, unitValue: 1, set: 3, wodSets: (0..<3).map { .init(order: $0, unitValue: 1, isCompleted: false) })
    static let main8: Self = .init(title: "싯업", subTitle: "lowing abc", unit: .repetitions, unitValue: 15, set: 3, wodSets: (0..<3).map { .init(order: $0, unitValue: 15, isCompleted: false) })
    static let main9: Self = .init(title: "사이드 플랭크", subTitle: "lowing abc", unit: .seconds, unitValue: 30, set: 3, wodSets: (0..<3).map { .init(order: $0, unitValue: 30, isCompleted: false) })
    static let main10: Self = .init(title: "스러스터", subTitle: "lowing abc", unit: .repetitions, unitValue: 10, set: 3, wodSets: (0..<3).map { .init(order: $0, unitValue: 10, isCompleted: false) })
    static let main11: Self = .init(title: "체스트 투 바 풀업", subTitle: "lowing abc", unit: .repetitions, unitValue: 5, set: 3, wodSets: (0..<3).map { .init(order: $0, unitValue: 5, isCompleted: false) })
    static let main12: Self = .init(title: "플라이오메트릭 푸시업", subTitle: "lowing abc", unit: .repetitions, unitValue: 8, set: 3, wodSets: (0..<3).map { .init(order: $0, unitValue: 8, isCompleted: false) })
    static let main13: Self = .init(title: "피스톨 스쿼트", subTitle: "lowing abc", unit: .repetitions, unitValue: 5, set: 3, wodSets: (0..<3).map { .init(order: $0, unitValue: 5, isCompleted: false) })
    static let main14: Self = .init(title: "스쿼트", subTitle: "lowing abc", unit: .repetitions, unitValue: 10, set: 3, wodSets: (0..<3).map { .init(order: $0, unitValue: 10, isCompleted: false) })
    static let main15: Self = .init(title: "버피", subTitle: "lowing abc", unit: .repetitions, unitValue: 10, set: 3, wodSets: (0..<3).map { .init(order: $0, unitValue: 10, isCompleted: false) })
    static let main16: Self = .init(title: "케틀벨 스윙", subTitle: "lowing abc", unit: .repetitions, unitValue: 10, set: 3, wodSets: (0..<3).map { .init(order: $0, unitValue: 10, isCompleted: false) })

    //MARK: - Cool Down
    static let coolDown1: Self = .init(title: "플랭크", subTitle: "lowing abc", unit: .minutes, unitValue: 1, set: nil, wodSets: nil)
    static let coolDown2: Self = .init(title: "스트레칭", subTitle: "lowing abc", unit: .minutes, unitValue: 3, set: nil, wodSets: nil)
    static let coolDown3: Self = .init(title: "레그 레이즈", subTitle: "lowing abc", unit: .minutes, unitValue: 1, set: nil, wodSets: nil)
    static let coolDown4: Self = .init(title: "햄스트링 스트레치", subTitle: "lowing abc", unit: .minutes, unitValue: 2, set: nil, wodSets: nil)
    static let coolDown5: Self = .init(title: "척추 트위스트 스트레치", subTitle: "lowing abc", unit: .minutes, unitValue: 2, set: nil, wodSets: nil)
    static let coolDown6: Self = .init(title: "캣카우 스트레치", subTitle: "lowing abc", unit: .minutes, unitValue: 2, set: nil, wodSets: nil)
    static let coolDown7: Self = .init(title: "고양이 소등 스트레치", subTitle: "lowing abc", unit: .minutes, unitValue: 2, set: nil, wodSets: nil)
    static let coolDown8: Self = .init(title: "로잉 머신", subTitle: "lowing abc", unit: .minutes, unitValue: 2, set: nil, wodSets: nil)
    static let coolDown9: Self = .init(title: "자전거", subTitle: "lowing abc", unit: .minutes, unitValue: 2, set: nil, wodSets: nil)
    static let coolDown10: Self = .init(title: "척추 트위스트 스트레치", subTitle: "lowing abc", unit: .minutes, unitValue: 2, set: nil, wodSets: nil)
}
