//
//  DayWorkoutModel.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//

import Foundation

struct DayWorkoutModel: Equatable, Identifiable {

    let id: UUID
    let type: WorkOutDayTagType
    let title: String
    let subTitle: String
    let expectedMinutes: Int
    let minExpectedCalorie: Int
    let maxExpectedCalorie: Int
    let workouts: [WorkoutModel]

    init(entity: DayWorkoutEntity) {
        self.id = entity.id
        self.type = WorkOutDayTagType(rawValue: entity.type) ?? .default
        self.title = entity.title
        self.subTitle = entity.subTitle
        self.expectedMinutes = Int(entity.expectedMinutes)
        self.minExpectedCalorie = Int(entity.minExpectedCalorie)
        self.maxExpectedCalorie = Int(entity.maxExpectedCalorie)
        self.workouts = entity.workouts.map {
            WorkoutModel(entity: $0 as! WorkoutEntity)
        }
    }

    init(id: UUID, type: WorkOutDayTagType, title: String, subTitle: String, expectedMinutes: Int, minExpectedCalorie: Int, maxExpectedCalorie: Int, workoutInfos: [WorkoutModel]) {
        self.id = id
        self.type = type
        self.title = title
        self.subTitle = subTitle
        self.expectedMinutes = expectedMinutes
        self.minExpectedCalorie = minExpectedCalorie
        self.maxExpectedCalorie = maxExpectedCalorie
        self.workouts = workoutInfos
    }

}

extension DayWorkoutModel {

    var isCompleteAllItem: Bool {
        self.workouts.allSatisfy { $0.wods.allSatisfy { $0.wodSets.allSatisfy { $0.isCompleted }}}
    }

}

extension DayWorkoutModel {

    static let preview: Self = .init(id: UUID(),
                                     type: .start,
                                     title: "알파 데이",
                                     subTitle: "한 주를 힘차게 시작하는",
                                     expectedMinutes: 60,
                                     minExpectedCalorie: 445,
                                     maxExpectedCalorie: 550,
                                     workoutInfos: [
                                        .init(id: UUID(), type: .warmUp, wods: [
                                            .init(id: UUID(),
                                                  title: "트레드밀",
                                                  subTitle: "lowing abc",
                                                  unit: .minutes,
                                                  unitValue: 5,
                                                  set: 1,
                                                  wodSets: [
                                                    .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false)
                                                  ]),
                                            .init(id: UUID(),
                                                  title: "시티드 덤벨 바이셉스 컬",
                                                  subTitle: "lowing abc",
                                                  unit: .repetitions,
                                                  unitValue: 12,
                                                  set: 2,
                                                  wodSets: [
                                                    .init(id: UUID(),order: 1, unitValue: 1, isCompleted: false),
                                                    .init(id: UUID(),order: 2, unitValue: 2, isCompleted: false)
                                                  ])
                                        ]),
                                        .init(id: UUID(), type: .main, wods: [
                                            .init(id: UUID(),
                                                  title: "체스트 프레스 머신",
                                                  subTitle: "lowing abc",
                                                  unit: .repetitions,
                                                  unitValue: 12,
                                                  set: 3,
                                                  wodSets: [
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
                                                  wodSets: [
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
                                                  wodSets: [
                                                    .init(id: UUID(),order: 1, unitValue: 1, isCompleted: false),
                                                    .init(id: UUID(),order: 2, unitValue: 2, isCompleted: false),
                                                    .init(id: UUID(),order: 3, unitValue: 3, isCompleted: false)
                                                  ])
                                        ]),
                                        .init(id: UUID(), type: .coolDown, wods: [
                                            .init(id: UUID(),
                                                  title: "엘립티컬 머신",
                                                  subTitle: "lowing abc",
                                                  unit: .minutes,
                                                  unitValue: 5,
                                                  set: 2,
                                                  wodSets: [
                                                    .init(id: UUID(),order: 1, unitValue: 1, isCompleted: false),
                                                    .init(id: UUID(),order: 2, unitValue: 2, isCompleted: false)
                                                  ]),
                                            .init(id: UUID(),
                                                  title: "타이거 크롤",
                                                  subTitle: "lowing abc",
                                                  unit: .seconds,
                                                  unitValue: 20,
                                                  set: 2,
                                                  wodSets: [
                                                    .init(id: UUID(),order: 1, unitValue: 1, isCompleted: false),
                                                    .init(id: UUID(),order: 2, unitValue: 2, isCompleted: false)
                                                  ])
                                        ])
                                     ])
}
