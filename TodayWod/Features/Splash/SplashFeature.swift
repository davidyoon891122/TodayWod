//
//  SplashFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/7/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SplashFeature {

    @ObservableState
    struct State: Equatable {
        let title: String = "todaywod"
        var opacity: Double = 0.0
        var isFinished = false
    }

    enum Action {
        case onAppear
        case finishSplash
    }

    @Dependency(\.continuousClock) var clock

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.opacity = 1.0
                return .run { send in
                    try await clock.sleep(for: .seconds(3))
                    await send(.finishSplash)
                }

            case .finishSplash:
                state.isFinished = true
               return .none
            }
        }
    }

}

import SwiftUI

struct SplashView: View {

    let store: StoreOf<SplashFeature>

    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text(store.title)
                    .bold()
                    .font(.system(size: 26.0))
                    .foregroundStyle(.white)
                    .opacity(store.opacity)
            }
            .animation(.spring(duration: 3), value: store.opacity)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                store.send(.onAppear)
            }
            .background(Colors.splashBackground.swiftUIColor)
        }
    }
}


#Preview {
    SplashView(store: Store(initialState: SplashFeature.State()) {
        SplashFeature()
    })
}
