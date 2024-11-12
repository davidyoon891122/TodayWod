//
//  WorkOutTests.swift
//  TodayWod
//
//  Created by 오지연 on 11/12/24.
//

import Testing
import ComposableArchitecture

@testable import TodayWod

@MainActor
struct WorkOutTests {
    
    @Test
    func didTapNewChallenge() async {
        
        let initModel = ProgramModel.bodyBeginner
        
        let newEntity = ProgramEntity.fake
        let newModel = ProgramModel(data: newEntity)
        
        let store = TestStore(initialState: WorkOutFeature.State()) {
            WorkOutFeature()
        } withDependencies: {
//            $0.apiClient = .testValue
            $0.wodClient = .testValue
//            $0.userDefaultsClient = .testValue
            
//            $0.wodClient.getCurrentProgram = { @Sendable in
//                initModel
//            }
            
//            $0.apiClient.requestOtherRandomProgram = { @Sendable _ in
//                newEntity
//            }
        }
        
        store.exhaustivity = .off
        
        await store.send(.onAppear)
        await store.receive(\.loadResult) {
            $0.ownProgram = initModel
        }

//        await store.send(.didTapNewChallengeButton) {
//            $0.alert = AlertState {
//                TextState("새로운 도전")
//            } actions: {
//                ButtonState(role: .destructive) {
//                    TextState("취소")
//                }
//                ButtonState(role: .cancel, action: .send(.startNewChallenge)) {
//                    TextState("확인")
//                }
//            } message: {
//                TextState("새로운 운동 루틴을 만들어요")
//            }
//        }
//        
//        await store.send(\.alert.startNewChallenge) {
//            $0.ownProgram = initModel
//        }
//        
//        await store.receive(\.updateOwnProgram) {
//            $0.ownProgram = newModel
//        }
    }
    
}
