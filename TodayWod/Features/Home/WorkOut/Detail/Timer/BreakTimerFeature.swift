//
//  BreakTimerFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/21/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct BreakTimerFeature {

    @ObservableState
    struct State: Equatable {
        @Shared(.appStorage("BreakTime")) var defaultTime: Int = 60
        var currentSeconds: Int = 0
        var buttonState: ButtonState = .pause
    }

    enum Action {
        case onAppear
        case timerTick
        case didTapReset
        case didTapPause
        case didTapResume
        case setButtonState
        case setDefaultTime
    }

    enum CancelID { case timer }

    enum ButtonState {
        case pause
        case play
    }

    @Dependency(\.continuousClock) var clock

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.currentSeconds = state.defaultTime
                return .none
            case .timerTick:
                if state.currentSeconds <= 0 {
                    return .cancel(id: CancelID.timer)
                }

                state.currentSeconds -= 1
                return .none
            case .didTapReset:
                state.currentSeconds = state.defaultTime
                state.buttonState = .play
                return .concatenate(
                    .cancel(id: CancelID.timer),
                    .run { send in
                        while true {
                            try await Task.sleep(for: .seconds(1))
                            await send(.timerTick)
                        }
                    }
                    .cancellable(id: CancelID.timer)
                )
            case .didTapPause:
                return .cancel(id: CancelID.timer)
            case .didTapResume:
                return .run { send in
                    while true {
                        try await Task.sleep(for: .seconds(1))
                        await send(.timerTick)
                    }
                }
                .cancellable(id: CancelID.timer)
            case .setButtonState:
                switch state.buttonState {
                case .pause:
                    state.buttonState = .play
                    return .send(.didTapResume)
                case .play:
                    state.buttonState = .pause
                    return .send(.didTapPause)
                }
            case .setDefaultTime:
                state.currentSeconds = state.defaultTime
                return .cancel(id: CancelID.timer)
            }
        }
    }

}

import SwiftUI
struct BreakTimerView: View {

    let store: StoreOf<BreakTimerFeature>

    var body: some View {
        WithPerceptionTracking {
            
            VStack {
                HStack {
                    Text("휴식")
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                        .foregroundStyle(.white100)
                    
                    Text("\(store.state.currentSeconds) 초")
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 28.0))
                        .foregroundStyle(.white100)
                    Spacer()
                    Button(action: {
                        store.send(.didTapReset)
                    }, label: {
                        Images.icRefresh24.swiftUIImage
                    })
                    
                    Button(action: {
                        store.send(.setButtonState)
                    }, label: {
                        if (store.buttonState == .pause) {
                            Images.icPlay24.swiftUIImage
                        } else {
                            Images.icPause24.swiftUIImage
                        }
                        
                    })
                }
                .padding(.horizontal, 20.0)
                .padding(.vertical, 20.0)
                .background(.blue60)
                .clipShape(.rect(cornerRadius: 16.0))
            }
            .padding(20.0)
            .background(.clear)
            .onAppear {
                store.send(.onAppear)
            }

        }
    }

}

#Preview {
    BreakTimerView(store: Store(initialState: BreakTimerFeature.State()) {
        BreakTimerFeature()
    })
}
