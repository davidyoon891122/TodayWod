//
//  RecentActivityModel.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/21/24.
//

import Foundation

struct RecentActivityModel: Codable, Equatable {

    var dayWorkOuts: [DayWorkOutModel]

}

extension RecentActivityModel {

    static let fake: Self = .init(dayWorkOuts: DayWorkOutModel.fakes)

}
