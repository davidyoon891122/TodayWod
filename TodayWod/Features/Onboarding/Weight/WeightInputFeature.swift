//
//  WeightInputFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/16/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct WeightInputFeature {

    @ObservableState
    struct State: Equatable {
        var onboardingUserModel: OnboardingUserInfoModel
    }

    enum Action {

    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {

            }
        }
    }

}

import SwiftUI

struct WeightInputView: View {

    let store: StoreOf<WeightInputFeature>

    var body: some View {
        VStack {
            Text("InputView")
        }
    }

}

#Preview {
    WeightInputView(store: Store(initialState: WeightInputFeature.State(onboardingUserModel: .init())) {
        WeightInputFeature()
    })
}
