//
//  RecentDayWorkOut+Entity.swift
//  TodayWod
//
//  Created by 오지연 on 10/13/24.
//

struct RecentDayWorkOutEntity: Codable, Equatable {
    
    var date: String
    var duration: Int
    let type: DayWorkOutTagType
    let title: String
    let subTitle: String
    let expectedMinute: Int
    let minEstimatedCalorie: Int
    let maxEstimatedCalorie: Int
    var workOuts: [WorkOutEntity]
    
}

extension RecentDayWorkOutEntity {
    
    static var fakes: [Self] = [
        .init(date: "20240931", duration: 120, type: .start, title: "알파 데이", subTitle: "한주를 시작하는", expectedMinute: 60, minEstimatedCalorie: 400, maxEstimatedCalorie: 500, workOuts: WorkOutEntity.bodyBeginnerAlphaDay1Info),
        .init(date: "20241002", duration: 120, type: .end, title: "히어로 데이", subTitle: "열정적인", expectedMinute: 60, minEstimatedCalorie: 400, maxEstimatedCalorie: 500, workOuts: WorkOutEntity.bodyBeginnerAlphaDay2Info)
    ]

}
