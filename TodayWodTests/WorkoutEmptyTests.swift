//
//  WorkoutEmptyTests.swift
//  TodayWodTests
//
//  Created by 오지연 on 11/13/24.
//

import Testing
import ComposableArchitecture

@testable import TodayWod

@MainActor
struct WorkoutEmptyTests {

    @Test
    func onAppear() async {
        let store = TestStore(initialState: WorkOutEmptyFeature.State()) {
            WorkOutEmptyFeature()
        } withDependencies: { value in
            value.apiClient = .testValue
            value.wodClient = .testValue
            value.userDefaultsClient = .testValue
        }
        
        store.exhaustivity = .off
        
        await store.send(.onAppear) {
            $0.onboardingUserModel = nil
        }
    }

}
