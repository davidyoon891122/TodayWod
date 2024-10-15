//
//  WorkOutListFeature.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct WorkOutListFeature {

    @ObservableState
    struct State: Equatable {
        var dayWorkouts: [DayWorkoutModel] = []
    }
    
    enum Action {
        case didTapAddProgram
        case didTapDeleteProgram
        case dayModelsResult(Result<[DayWorkoutModel], Error>)
        case onAppear
        case removeProgramResult(Result<Void, Error>)
    }

    @Dependency(\.wodClient) var wodClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    do {
                        let dayModels = try wodClient.getDayModels()
                        await send(.dayModelsResult(.success(dayModels)))
                    } catch {
                        await send(.dayModelsResult(.failure(error)))
                    }
                }
            case .didTapAddProgram:
                return .run { send in
                    do {
                        let programsModel = ProgramModel.bodyBeginner // TODO: Fake 대체 필요.
                        let result = try wodClient.addWodProgram(programsModel)
                        await send(.dayModelsResult(.success(result.dayWorkouts)))
                    } catch {
                        await send(.dayModelsResult(.failure(error)))
                    }
                }
            case .dayModelsResult(.success(let result)):
                state.dayWorkouts = result
                return .none
            case .dayModelsResult(.failure(let error)):
                // TODO: - 에러 표시 여기서
                state.dayWorkouts = []
                return .none
            case .didTapDeleteProgram:
                // TODO: - 프로그램 제거  
                return .run { send in
                    do {
                        try wodClient.removePrograms()
                        await send(.removeProgramResult(.success(())))
                    } catch {
                        await send(.removeProgramResult(.failure(error)))
                    }
                }
            case .removeProgramResult(.success(_)):
                state.dayWorkouts = []
                return .none
            case .removeProgramResult(.failure(let error)):
                print("fail to delete programs : \(error.localizedDescription)")
                return .none
            }
        }
    }
    
}

import SwiftUI
struct WorkOutListView: View {

    let store: StoreOf<WorkOutListFeature>

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button(action: {
                        store.send(.didTapAddProgram)
                    }, label: {
                        Text("와드 프로그램 추가하기")
                            .frame(maxWidth: .infinity, minHeight: 56.0)
                            .background(.yellow)
                            .foregroundStyle(.black100)
                    })

                    Button(action: {
                        store.send(.didTapDeleteProgram)
                    }, label: {
                        Text("와드 프로그램 제거하기")
                            .frame(maxWidth: .infinity, minHeight: 56.0)
                            .background(.yellow)
                            .foregroundStyle(.black100)
                    })

                }
                .padding()

                LazyVStack {
                    ForEach(store.state.dayWorkouts) { dayWorkout in
                        HStack {
                            Text(dayWorkout.title)
                            Text(dayWorkout.subTitle)
                        }
                    }
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
    
}

#Preview {
    WorkOutListView(store: .init(initialState: WorkOutListFeature.State()) {
        WorkOutListFeature()
    })
}
