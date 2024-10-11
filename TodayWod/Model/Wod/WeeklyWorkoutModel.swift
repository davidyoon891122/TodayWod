//
//  WeeklyWorkoutModel.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//

import Foundation

struct WeeklyWorkoutModel: Equatable, Identifiable {

    let id: UUID
    let type: WorkOutDayTagType
    let title: String
    let subTitle: String
    let expectedMinutes: Int
    let minExpectedCalories: Int
    let maxExpectedCalories: Int
    let dayWorkouts: [DayWorkoutModel]

    init(entity: WeeklyWorkoutEntity) {
        self.id = entity.id
        self.type = WorkOutDayTagType(rawValue: entity.type) ?? .default
        self.title = entity.title
        self.subTitle = entity.subTitle
        self.expectedMinutes = Int(entity.expectedMinutes)
        self.minExpectedCalories = Int(entity.minExpectedCalories)
        self.maxExpectedCalories = Int(entity.maxExpectedCalories)
        self.dayWorkouts = entity.dayWorkouts.map {
            DayWorkoutModel(entity: $0 as! DayWorkoutEntity)
        }
    }

    init(id: UUID, type: WorkOutDayTagType, title: String, subTitle: String, expectedMinutes: Int, minExpectedCalories: Int, maxExpectedCalories: Int, workoutInfos: [DayWorkoutModel]) {
        self.id = id
        self.type = type
        self.title = title
        self.subTitle = subTitle
        self.expectedMinutes = expectedMinutes
        self.minExpectedCalories = minExpectedCalories
        self.maxExpectedCalories = maxExpectedCalories
        self.dayWorkouts = workoutInfos
    }

}

extension WeeklyWorkoutModel {

    var isCompleteAllItem: Bool {
        self.dayWorkouts.allSatisfy { $0.wods.allSatisfy { $0.wodSet.allSatisfy { $0.isCompleted }}}
    }

}

extension WeeklyWorkoutModel {

    static let preview: Self = .init(id: UUID(),
                                     type: .start,
                                     title: "알파 데이",
                                     subTitle: "한 주를 힘차게 시작하는",
                                     expectedMinutes: 60,
                                     minExpectedCalories: 445,
                                     maxExpectedCalories: 550,
                                     workoutInfos: [
                                        .init(id: UUID(), type: .warmUp, workOutItems: [
                                            .init(id: UUID(),
                                                  title: "트레드밀",
                                                  subTitle: "lowing abc",
                                                  unit: .minutes,
                                                  unitValue: 5,
                                                  set: 1,
                                                  wodSet: [
                                                    .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false)
                                                  ]),
                                            .init(id: UUID(),
                                                  title: "시티드 덤벨 바이셉스 컬",
                                                  subTitle: "lowing abc",
                                                  unit: .repetitions,
                                                  unitValue: 12,
                                                  set: 2,
                                                  wodSet: [
                                                    .init(id: UUID(),order: 1, unitValue: 1, isCompleted: false),
                                                    .init(id: UUID(),order: 2, unitValue: 2, isCompleted: false)
                                                  ])
                                        ]),
                                        .init(id: UUID(), type: .main, workOutItems: [
                                            .init(id: UUID(),
                                                  title: "체스트 프레스 머신",
                                                  subTitle: "lowing abc",
                                                  unit: .repetitions,
                                                  unitValue: 12,
                                                  set: 3,
                                                  wodSet: [
                                                    .init(id: UUID(),order: 1,unitValue: 1, isCompleted: false),
                                                    .init(id: UUID(),order: 2,unitValue: 2, isCompleted: false),
                                                    .init(id: UUID(),order: 3,unitValue: 3, isCompleted: false)
                                                  ]),
                                            .init(id: UUID(),
                                                  title: "힙 어브덕터/애덕터 머신",
                                                  subTitle: "lowing abc",
                                                  unit: .repetitions,
                                                  unitValue: 12,
                                                  set: 3,
                                                  wodSet: [
                                                    .init(id: UUID(),order: 1, unitValue: 1, isCompleted: false),
                                                    .init(id: UUID(),order: 2, unitValue: 2, isCompleted: false),
                                                    .init(id: UUID(),order: 3, unitValue: 3, isCompleted: false)
                                                  ]),
                                            .init(id: UUID(),
                                                  title: "로우 러시안 트위스트",
                                                  subTitle: "lowing abc",
                                                  unit: .repetitions,
                                                  unitValue: 30,
                                                  set: 3,
                                                  wodSet: [
                                                    .init(id: UUID(),order: 1, unitValue: 1, isCompleted: false),
                                                    .init(id: UUID(),order: 2, unitValue: 2, isCompleted: false),
                                                    .init(id: UUID(),order: 3, unitValue: 3, isCompleted: false)
                                                  ])
                                        ]),
                                        .init(id: UUID(), type: .coolDown, workOutItems: [
                                            .init(id: UUID(),
                                                  title: "엘립티컬 머신",
                                                  subTitle: "lowing abc",
                                                  unit: .minutes,
                                                  unitValue: 5,
                                                  set: 2,
                                                  wodSet: [
                                                    .init(id: UUID(),order: 1, unitValue: 1, isCompleted: false),
                                                    .init(id: UUID(),order: 2, unitValue: 2, isCompleted: false)
                                                  ]),
                                            .init(id: UUID(),
                                                  title: "타이거 크롤",
                                                  subTitle: "lowing abc",
                                                  unit: .seconds,
                                                  unitValue: 20,
                                                  set: 2,
                                                  wodSet: [
                                                    .init(id: UUID(),order: 1, unitValue: 1, isCompleted: false),
                                                    .init(id: UUID(),order: 2, unitValue: 2, isCompleted: false)
                                                  ])
                                        ])
                                     ])
}
