//
//  WodInfo+Dummy.swift
//  TodayWod
//
//  Created by 오지연 on 9/29/24.
//

import Foundation

extension WodInfoEntityOrigin {
    
    static let bodyBeginners: [Self] = [
        .init(methodType: .body, level: .beginner, workOutDays: WorkOutDayEntityOrigin.bodyBeginnerAlphaWeek),
        .init(methodType: .body, level: .beginner, workOutDays: WorkOutDayEntityOrigin.bodyBeginnerBetaWeek),
        .init(methodType: .body, level: .beginner, workOutDays: WorkOutDayEntityOrigin.bodyBeginnerCharlieWeek)
    ]
    
}

extension WorkOutDayEntityOrigin {
    
    static let bodyBeginnerAlphaWeek: [Self] = [
        .init(type: .start, title: "상체 근력", subTitle: "Upper Body Strength", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerAlphaDay1Info),
        .init(type: .default, title: "하체 근력", subTitle: "Lower Body Strength", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerAlphaDay2Info),
        .init(type: .default, title: "코어 강화", subTitle: "Core Strength", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerAlphaDay3Info),
        .init(type: .default, title: "전신 운동", subTitle: "Full Body Conditioning", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerAlphaDay4Info),
        .init(type: .default, title: "상체 지구력", subTitle: "Upper Body Endurance", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerAlphaDay5Info),
        .init(type: .end, title: "하체 지구력", subTitle: "Lower Body Endurance", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerAlphaDay6Info)
    ]
    
    static let bodyBeginnerBetaWeek: [Self] = [
        .init(type: .start, title: "전신 근력", subTitle: "Full Body Strength", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerBetaDay1Info),
        .init(type: .default, title: "하체 근력", subTitle: "Lower Body Strength", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerBetaDay2Info),
        .init(type: .default, title: "코어 및 상체 근력", subTitle: "Core and Upper Body Strength", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerBetaDay3Info),
        .init(type: .default, title: "전신 지구력", subTitle: "Full Body Endurance", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerBetaDay4Info),
        .init(type: .default, title: "하체 지구력", subTitle: "Lower Body Endurance", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerBetaDay5Info),
        .init(type: .end, title: "상체 지구력", subTitle: "Upper Body Endurance", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerBetaDay6Info)
    ]
    
    static let bodyBeginnerCharlieWeek: [Self] = [
        .init(type: .start, title: "상체 지구력", subTitle: "Upper Body Endurance", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerCharlieDay1Info),
        .init(type: .default, title: "하체 근력", subTitle: "Lower Body Strength", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerCharlieDay2Info),
        .init(type: .default, title: "전신 지구력", subTitle: "Full Body Endurance", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerCharlieDay3Info),
        .init(type: .default, title: "코어 및 상체 근력", subTitle: "Core and Upper Body Strength", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerCharlieDay4Info),
        .init(type: .default, title: "하체 지구력", subTitle: "Lower Body Endurance", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerCharlieDay5Info),
        .init(type: .end, title: "전신 근력", subTitle: "Full Body Strength", expectedMinute: 60, estimatedMinCalorie: 400, estimatedMaxCalorie: 500, workOuts: WorkOutInfoEntityOrigin.bodyBeginnerCharlieDay6Info)
    ]
    
}

extension WorkOutInfoEntityOrigin {
    
    //MARK: - Alpha
    static let bodyBeginnerAlphaDay1Info: [Self] = [
        .init(type: .WarmUp, items: [WodEntityOrigin.warmUp1, WodEntityOrigin.warmUp2]),
        .init(type: .Main, items: [WodEntityOrigin.main1, WodEntityOrigin.main2, WodEntityOrigin.main3]),
        .init(type: .CoolDown, items: [WodEntityOrigin.coolDown1, WodEntityOrigin.coolDown2])
    ]
    
    static let bodyBeginnerAlphaDay2Info: [Self] = [
        .init(type: .WarmUp, items: [WodEntityOrigin.warmUp3, WodEntityOrigin.warmUp4]),
        .init(type: .Main, items: [WodEntityOrigin.main4, WodEntityOrigin.main5, WodEntityOrigin.main6]),
        .init(type: .CoolDown, items: [WodEntityOrigin.coolDown3, WodEntityOrigin.coolDown4])
    ]
    
    static let bodyBeginnerAlphaDay3Info: [Self] = [
        .init(type: .WarmUp, items: [WodEntityOrigin.warmUp1, WodEntityOrigin.warmUp5]),
        .init(type: .Main, items: [WodEntityOrigin.main7, WodEntityOrigin.main8, WodEntityOrigin.main9]),
        .init(type: .CoolDown, items: [WodEntityOrigin.coolDown5, WodEntityOrigin.coolDown6])
    ]
    
    static let bodyBeginnerAlphaDay4Info: [Self] = [
        .init(type: .WarmUp, items: [WodEntityOrigin.warmUp2, WodEntityOrigin.warmUp6]),
        .init(type: .Main, items: [WodEntityOrigin.main10, WodEntityOrigin.main1, WodEntityOrigin.main3]),
        .init(type: .CoolDown, items: [WodEntityOrigin.coolDown1, WodEntityOrigin.coolDown2])
    ]
    
    static let bodyBeginnerAlphaDay5Info: [Self] = [
        .init(type: .WarmUp, items: [WodEntityOrigin.warmUp7, WodEntityOrigin.warmUp1]),
        .init(type: .Main, items: [WodEntityOrigin.main11, WodEntityOrigin.main2, WodEntityOrigin.main12]),
        .init(type: .CoolDown, items: [WodEntityOrigin.coolDown1, WodEntityOrigin.coolDown7])
    ]
    
    static let bodyBeginnerAlphaDay6Info: [Self] = [
        .init(type: .WarmUp, items: [WodEntityOrigin.warmUp3, WodEntityOrigin.warmUp2]),
        .init(type: .Main, items: [WodEntityOrigin.main13, WodEntityOrigin.main5, WodEntityOrigin.main6]),
        .init(type: .CoolDown, items: [WodEntityOrigin.coolDown4, WodEntityOrigin.coolDown2])
    ]
    
    //MARK: - Beta
    static let bodyBeginnerBetaDay1Info: [Self] = [
        .init(type: .WarmUp, items: [WodEntityOrigin.warmUp4, WodEntityOrigin.warmUp3]),
        .init(type: .Main, items: [WodEntityOrigin.main4, WodEntityOrigin.main10, WodEntityOrigin.main3]),
        .init(type: .CoolDown, items: [WodEntityOrigin.coolDown2, WodEntityOrigin.coolDown1])
    ]
    
    static let bodyBeginnerBetaDay2Info: [Self] = [
        .init(type: .WarmUp, items:  [WodEntityOrigin.warmUp2, WodEntityOrigin.warmUp1]),
        .init(type: .Main, items: [WodEntityOrigin.main6, WodEntityOrigin.main13, WodEntityOrigin.main5]),
        .init(type: .CoolDown, items: [WodEntityOrigin.coolDown4, WodEntityOrigin.coolDown3])
    ]
    
    static let bodyBeginnerBetaDay3Info: [Self] = [
        .init(type: .WarmUp, items: [WodEntityOrigin.warmUp1, WodEntityOrigin.warmUp5]),
        .init(type: .Main, items: [WodEntityOrigin.main11, WodEntityOrigin.main2, WodEntityOrigin.main9]),
        .init(type: .CoolDown, items: [WodEntityOrigin.coolDown5, WodEntityOrigin.coolDown1])
    ]
    
    static let bodyBeginnerBetaDay4Info: [Self] = [
        .init(type: .WarmUp, items: [WodEntityOrigin.warmUp2, WodEntityOrigin.warmUp6]),
        .init(type: .Main, items: [WodEntityOrigin.main14, WodEntityOrigin.main1, WodEntityOrigin.main15]),
        .init(type: .CoolDown, items: [WodEntityOrigin.coolDown2, WodEntityOrigin.coolDown7])
    ]
    
    static let bodyBeginnerBetaDay5Info: [Self] = [
        .init(type: .WarmUp, items: [WodEntityOrigin.warmUp3, WodEntityOrigin.warmUp1]),
        .init(type: .Main, items: [WodEntityOrigin.main5, WodEntityOrigin.main13, WodEntityOrigin.main16]),
        .init(type: .CoolDown, items:  [WodEntityOrigin.coolDown1, WodEntityOrigin.coolDown4])
    ]
    
    static let bodyBeginnerBetaDay6Info: [Self] = [
        .init(type: .WarmUp, items: [WodEntityOrigin.warmUp7, WodEntityOrigin.warmUp8]),
        .init(type: .Main, items: [WodEntityOrigin.main11, WodEntityOrigin.main12, WodEntityOrigin.main2]),
        .init(type: .CoolDown, items: [WodEntityOrigin.coolDown7, WodEntityOrigin.coolDown1])
    ]
    
    //MARK: - Charlie
    static let bodyBeginnerCharlieDay1Info: [Self] = [
        .init(type: .WarmUp, items: [WodEntityOrigin.warmUp1, WodEntityOrigin.warmUp2, WodEntityOrigin.warmUp9]),
        .init(type: .Main, items: [WodEntityOrigin.main11, WodEntityOrigin.main2, WodEntityOrigin.main12]),
        .init(type: .CoolDown, items: [WodEntityOrigin.coolDown1, WodEntityOrigin.coolDown8])
    ]
    
    static let bodyBeginnerCharlieDay2Info: [Self] = [
        .init(type: .WarmUp, items: [WodEntityOrigin.warmUp4, WodEntityOrigin.warmUp3]),
        .init(type: .Main, items: [WodEntityOrigin.main4, WodEntityOrigin.main5, WodEntityOrigin.main3, WodEntityOrigin.main16]),
        .init(type: .CoolDown, items: [WodEntityOrigin.coolDown3, WodEntityOrigin.coolDown9])
    ]
    
    static let bodyBeginnerCharlieDay3Info: [Self] = [
        .init(type: .WarmUp, items: [WodEntityOrigin.warmUp2, WodEntityOrigin.warmUp6]),
        .init(type: .Main, items: [WodEntityOrigin.main10, WodEntityOrigin.main1, WodEntityOrigin.main15]),
        .init(type: .CoolDown, items: [WodEntityOrigin.coolDown8, WodEntityOrigin.coolDown9])
    ]
    
    static let bodyBeginnerCharlieDay4Info: [Self] = [
        .init(type: .WarmUp, items: [WodEntityOrigin.warmUp7, WodEntityOrigin.warmUp1]),
        .init(type: .Main, items: [WodEntityOrigin.main7, WodEntityOrigin.main11, WodEntityOrigin.main9]),
        .init(type: .CoolDown, items: [WodEntityOrigin.coolDown1, WodEntityOrigin.coolDown2])
    ]
    
    static let bodyBeginnerCharlieDay5Info: [Self] = [
        .init(type: .WarmUp, items: [WodEntityOrigin.warmUp3, WodEntityOrigin.warmUp5]),
        .init(type: .Main, items: [WodEntityOrigin.main13, WodEntityOrigin.main6, WodEntityOrigin.main5]),
        .init(type: .CoolDown, items: [WodEntityOrigin.coolDown4, WodEntityOrigin.coolDown3])
    ]
    
    static let bodyBeginnerCharlieDay6Info: [Self] = [
        .init(type: .WarmUp, items: [WodEntityOrigin.warmUp2, WodEntityOrigin.warmUp1]),
        .init(type: .Main, items: [WodEntityOrigin.main14, WodEntityOrigin.main1, WodEntityOrigin.main3]),
        .init(type: .CoolDown, items: [WodEntityOrigin.coolDown1, WodEntityOrigin.coolDown10])
    ]
}

extension WodEntityOrigin {
    //MARK: - Warm Up
    static let warmUp1: Self = .init(title: "암서클", subTitle: "lowing abc", unit: .minutes, unitValue: 2)
    static let warmUp2: Self = .init(title: "점핑잭", subTitle: "lowing abc", unit: .minutes, unitValue: 2)
    static let warmUp3: Self = .init(title: "에어 스쿼트", subTitle: "lowing abc", unit: .minutes, unitValue: 2)
    static let warmUp4: Self = .init(title: "인치웜 스트레치", subTitle: "lowing abc", unit: .minutes, unitValue: 2)
    static let warmUp5: Self = .init(title: "버피", subTitle: "lowing abc", unit: .minutes, unitValue: 2)
    static let warmUp6: Self = .init(title: "케틀벨 스윙", subTitle: "lowing abc", unit: .minutes, unitValue: 2)
    static let warmUp7: Self = .init(title: "푸쉬업", subTitle: "lowing abc", unit: .minutes, unitValue: 2)
    static let warmUp8: Self = .init(title: "햄스트링 스트레치", subTitle: "lowing abc", unit: .minutes, unitValue: 2)
    static let warmUp9: Self = .init(title: "러닝", subTitle: "lowing abc", unit: .minutes, unitValue: 2)
    
    //MARK: - Main WOD
    static let main1: Self = .init(title: "덤밸 스내치", subTitle: "lowing abc", unit: .repetitions, unitValue: 8, set: 3)
    static let main2: Self = .init(title: "핸드 릴리즈 푸시업", subTitle: "lowing abc", unit: .repetitions, unitValue: 10, set: 3)
    static let main3: Self = .init(title: "박스 점프", subTitle: "lowing abc", unit: .repetitions, unitValue: 8, set: 3)
    static let main4: Self = .init(title: "데드리프트", subTitle: "lowing abc", unit: .repetitions, unitValue: 8, set: 3)
    static let main5: Self = .init(title: "런지", subTitle: "lowing abc", unit: .repetitions, unitValue: 10, set: 3)
    static let main6: Self = .init(title: "싱글 레그 데드리프트", subTitle: "lowing abc", unit: .repetitions, unitValue: 8, set: 3)
    static let main7: Self = .init(title: "플랭크", subTitle: "lowing abc", unit: .minutes, unitValue: 1, set: 3)
    static let main8: Self = .init(title: "싯업", subTitle: "lowing abc", unit: .repetitions, unitValue: 15, set: 3)
    static let main9: Self = .init(title: "사이드 플랭크", subTitle: "lowing abc", unit: .seconds, unitValue: 30, set: 3)
    static let main10: Self = .init(title: "스러스터", subTitle: "lowing abc", unit: .repetitions, unitValue: 10, set: 3)
    static let main11: Self = .init(title: "체스트 투 바 풀업", subTitle: "lowing abc", unit: .repetitions, unitValue: 5, set: 3)
    static let main12: Self = .init(title: "플라이오메트릭 푸시업", subTitle: "lowing abc", unit: .repetitions, unitValue: 8, set: 3)
    static let main13: Self = .init(title: "피스톨 스쿼트", subTitle: "lowing abc", unit: .repetitions, unitValue: 5, set: 3)
    static let main14: Self = .init(title: "스쿼트", subTitle: "lowing abc", unit: .repetitions, unitValue: 10, set: 3)
    static let main15: Self = .init(title: "버피", subTitle: "lowing abc", unit: .repetitions, unitValue: 10, set: 3)
    static let main16: Self = .init(title: "케틀벨 스윙", subTitle: "lowing abc", unit: .repetitions, unitValue: 10, set: 3)
    
    //MARK: - Cool Down
    static let coolDown1: Self = .init(title: "플랭크", subTitle: "lowing abc", unit: .minutes, unitValue: 1)
    static let coolDown2: Self = .init(title: "스트레칭", subTitle: "lowing abc", unit: .minutes, unitValue: 3)
    static let coolDown3: Self = .init(title: "레그 레이즈", subTitle: "lowing abc", unit: .minutes, unitValue: 1)
    static let coolDown4: Self = .init(title: "햄스트링 스트레치", subTitle: "lowing abc", unit: .minutes, unitValue: 2)
    static let coolDown5: Self = .init(title: "척추 트위스트 스트레치", subTitle: "lowing abc", unit: .minutes, unitValue: 2)
    static let coolDown6: Self = .init(title: "캣카우 스트레치", subTitle: "lowing abc", unit: .minutes, unitValue: 2)
    static let coolDown7: Self = .init(title: "고양이 소등 스트레치", subTitle: "lowing abc", unit: .minutes, unitValue: 2)
    static let coolDown8: Self = .init(title: "로잉 머신", subTitle: "lowing abc", unit: .minutes, unitValue: 2)
    static let coolDown9: Self = .init(title: "자전거", subTitle: "lowing abc", unit: .minutes, unitValue: 2)
    static let coolDown10: Self = .init(title: "척추 트위스트 스트레치", subTitle: "lowing abc", unit: .minutes, unitValue: 2)

}
