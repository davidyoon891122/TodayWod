//
//  WodModel.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//

import Foundation

struct WodModel: Equatable, Identifiable {

    let id: UUID
    let title: String
    let subTitle: String
    let unit: ExerciseUnit
    let unitValue: Int
    let set: Int
    var wodSets: [WodSetModel]

    init(entity: WodEntity) {
        self.id = entity.id
        self.title = entity.title
        self.subTitle = entity.subTitle
        self.unit = ExerciseUnit(rawValue: entity.unit) ?? .seconds
        self.unitValue = Int(entity.unitValue)
        self.set = Int(entity.set)
        self.wodSets = entity.wodSets.map { WodSetModel(entity: $0 as! WodSetEntity) }
    }

    init(id: UUID, title: String, subTitle: String, unit: ExerciseUnit, unitValue: Int, set: Int, wodSets: [WodSetModel]) {
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.unit = unit
        self.unitValue = unitValue
        self.set = set
        self.wodSets = wodSets
    }

}
