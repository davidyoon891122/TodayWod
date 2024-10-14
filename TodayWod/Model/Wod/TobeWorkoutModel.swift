//
//  WorkoutModel.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//

import Foundation

struct TobeWorkoutModel: Equatable {

    let id: UUID
    let type: WorkOutType
    var wods: [TobeWodModel]

    init(entity: WorkoutEntity) {
        self.type = WorkOutType(rawValue: entity.type) ?? .coolDown
        self.wods = entity.wods.map {
            TobeWodModel(entity: $0 as! WodEntity)
        }
        self.id = entity.id
    }

    init(id: UUID, type: WorkOutType, wods: [TobeWodModel]) {
        self.id = id
        self.type = type
        self.wods = wods
    }

}

extension TobeWorkoutModel {
    
    var isCompleted: Bool {
        self.wods.allSatisfy { $0.wodSets.allSatisfy { $0.isCompleted } }
    }
    
}

extension TobeWorkoutModel {

    static let preview: Self = .init(id: UUID(), type: .warmUp, wods: [
        .init(id: UUID(), title: "트레드밀", subTitle: "lowing abc", unit: .minutes, unitValue: 5, set: 1, wodSets: [
            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false)
        ]),
        .init(id: UUID(), title: "시티드 덤벨 바이셉스 컬", subTitle: "lowing abc", unit: .repetitions, unitValue: 12, set: 2, wodSets: [
            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
        ])
    ])

}
