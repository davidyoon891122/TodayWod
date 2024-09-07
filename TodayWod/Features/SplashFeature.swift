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
    struct State {
        let title: String = "todaywod"
        var opacity: Double = 0.0
    }

    enum Action {
        case onAppear
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.opacity = 1.0
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
            .background(Color("SplashBackground"))
        }
    }
}


#Preview {
    SplashView(store: Store(initialState: SplashFeature.State()) {
        SplashFeature()
    })
}
