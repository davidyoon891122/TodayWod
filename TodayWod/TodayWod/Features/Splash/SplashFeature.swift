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
        let duration: Double = 3.0
        var opacity: Double = 0.0
    }

    enum Action {
        case onAppear
        case setDisplay
        case finishSplash
    }

    @Dependency(\.continuousClock) var clock

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                let duration = state.duration
                
                return .merge(.send(.setDisplay), .run(operation: { send in
                    try await clock.sleep(for: .seconds(duration))
                    await send(.finishSplash)
                }))
            case .setDisplay:
                state.opacity = 1.0
                return .none
            case .finishSplash:
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
                Text(Constants.title)
                    .bold()
                    .font(.system(size: 26.0))
                    .foregroundStyle(.white)
                    .opacity(store.opacity)
            }
            .animation(.spring(duration: store.duration), value: store.opacity)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                store.send(.onAppear)
            }
            .background(Colors.blue60.swiftUIColor)
        }
    }
}

private extension SplashView {
    
    enum Constants {
        static let title: String = "todaywod"
    }
    
}


#Preview {
    SplashView(store: Store(initialState: SplashFeature.State()) {
        SplashFeature()
    })
}
