//
//  DayWorkoutModel.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//

import Foundation

struct DayWorkoutModel: Equatable {

    let id: UUID
    let type: WorkOutType
    var wods: [WodModel]

    init(entity: DayWorkoutEntity) {
        self.type = WorkOutType(rawValue: entity.type) ?? .coolDown
        self.wods = entity.wods.map {
            WodModel(entity: $0 as! WodEntity)
        }
        self.id = entity.id
    }

    init(id: UUID, type: WorkOutType, workOutItems: [WodModel]) {
        self.id = id
        self.type = type
        self.wods = workOutItems
    }

}

extension DayWorkoutModel {
    
    var isCompleted: Bool {
        self.wods.allSatisfy { $0.wodSet.allSatisfy { $0.isCompleted } }
    }
    
}

extension DayWorkoutModel {

    static let preview: Self = .init(id: UUID(), type: .warmUp, workOutItems: [
        .init(id: UUID(), title: "트레드밀", subTitle: "lowing abc", unit: .minutes, unitValue: 5, set: 1, wodSet: [
            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false)
        ]),
        .init(id: UUID(), title: "시티드 덤벨 바이셉스 컬", subTitle: "lowing abc", unit: .repetitions, unitValue: 12, set: 2, wodSet: [
            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
        ])
    ])

}
