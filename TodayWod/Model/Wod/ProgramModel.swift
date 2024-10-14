//
//  ProgramsModel.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//

import Foundation

struct ProgramModel: Equatable {

    let id: UUID
    let methodType: ProgramMethodType
    let level: LevelType
    let dayWorkouts: [DayWorkoutModel]

    init(entity: ProgramEntity) {
        self.id = entity.id
        self.methodType = ProgramMethodType(rawValue: entity.methodType) ?? .body
        self.level = LevelType(rawValue: entity.level) ?? .beginner
        self.dayWorkouts = entity.dayWorkouts.map {
            DayWorkoutModel(entity: $0 as! DayWorkoutEntity)
        }
    }

    init(id: UUID, methodType: ProgramMethodType, level: LevelType, dayWorkouts: [DayWorkoutModel]) {
        self.id = id
        self.methodType = methodType
        self.level = level
        self.dayWorkouts = dayWorkouts
    }

}

extension ProgramModel {

    static let mock: Self = .init(id: UUID(), methodType: .body, level: .beginner, dayWorkouts: [
        .init(id: UUID(),
              type: .start,
              title: "알파 데이",
              subTitle: "한 주를 힘차게 시작하는",
              expectedMinutes: 60,
              minExpectedCalorie: 445,
              maxExpectedCalorie: 550,
              workouts: [
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
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .main, wods: [
                    .init(id: UUID(),
                          title: "체스트 프레스 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "힙 어브덕터/애덕터 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "로우 러시안 트위스트",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 30,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .coolDown, wods: [
                    .init(id: UUID(),
                          title: "엘립티컬 머신",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 2,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "타이거 크롤",
                          subTitle: "lowing abc",
                          unit: .seconds,
                          unitValue: 20,
                          set: 2,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ])
              ]),
        .init(id: UUID(),
              type: .default,
              title: "타이탄 데이",
              subTitle: "한 주를 힘차게 시작하는",
              expectedMinutes: 60,
              minExpectedCalorie: 445,
              maxExpectedCalorie: 550,
              workouts: [
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
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .main, wods: [
                    .init(id: UUID(),
                          title: "체스트 프레스 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "힙 어브덕터/애덕터 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "로우 러시안 트위스트",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 30,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .coolDown, wods: [
                    .init(id: UUID(),
                          title: "엘립티컬 머신",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 2,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "타이거 크롤",
                          subTitle: "lowing abc",
                          unit: .seconds,
                          unitValue: 20,
                          set: 2,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ])
              ]),
        .init(id: UUID(),
              type: .default,
              title: "히어로 데이",
              subTitle: "한 주를 힘차게 시작하는",
              expectedMinutes: 60,
              minExpectedCalorie: 445,
              maxExpectedCalorie: 550,
              workouts: [
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
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .main, wods: [
                    .init(id: UUID(),
                          title: "체스트 프레스 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "힙 어브덕터/애덕터 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "로우 러시안 트위스트",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 30,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .coolDown, wods: [
                    .init(id: UUID(),
                          title: "엘립티컬 머신",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 2,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "타이거 크롤",
                          subTitle: "lowing abc",
                          unit: .seconds,
                          unitValue: 20,
                          set: 2,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ])
              ]),
        .init(id: UUID(),
              type: .default,
              title: "블레디즈 데이",
              subTitle: "한 주를 힘차게 시작하는",
              expectedMinutes: 60,
              minExpectedCalorie: 445,
              maxExpectedCalorie: 550,
              workouts: [
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
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .main, wods: [
                    .init(id: UUID(),
                          title: "체스트 프레스 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "힙 어브덕터/애덕터 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "로우 러시안 트위스트",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 30,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .coolDown, wods: [
                    .init(id: UUID(),
                          title: "엘립티컬 머신",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 2,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "타이거 크롤",
                          subTitle: "lowing abc",
                          unit: .seconds,
                          unitValue: 20,
                          set: 2,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ])
              ]),
        .init(id: UUID(),
              type: .default,
              title: "피닉스 데이",
              subTitle: "한 주를 힘차게 시작하는",
              expectedMinutes: 60,
              minExpectedCalorie: 445,
              maxExpectedCalorie: 550,
              workouts: [
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
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .main, wods: [
                    .init(id: UUID(),
                          title: "체스트 프레스 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "힙 어브덕터/애덕터 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "로우 러시안 트위스트",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 30,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .coolDown, wods: [
                    .init(id: UUID(),
                          title: "엘립티컬 머신",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 2,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "타이거 크롤",
                          subTitle: "lowing abc",
                          unit: .seconds,
                          unitValue: 20,
                          set: 2,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ])
              ]),
        .init(id: UUID(),
              type: .end,
              title: "에이펙스 데이",
              subTitle: "한 주를 힘차게 시작하는",
              expectedMinutes: 60,
              minExpectedCalorie: 445,
              maxExpectedCalorie: 550,
              workouts: [
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
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .main, wods: [
                    .init(id: UUID(),
                          title: "체스트 프레스 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "힙 어브덕터/애덕터 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "로우 러시안 트위스트",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 30,
                          set: 3,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .coolDown, wods: [
                    .init(id: UUID(),
                          title: "엘립티컬 머신",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 2,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "타이거 크롤",
                          subTitle: "lowing abc",
                          unit: .seconds,
                          unitValue: 20,
                          set: 2,
                          wodSets: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ])
              ])
    ])
}
