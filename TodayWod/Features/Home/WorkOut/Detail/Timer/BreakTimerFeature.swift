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
        @Shared(.appStorage(SharedConstants.breakTime)) var defaultTime: Int = 60
        var currentSeconds: Int = 0
        var timerState: TimerState = .stop
    }

    enum Action {
        case onAppear
        case onDisappear
        case timerTick
        case didTapReset
        case stopTimer
        case startTimer
        case didTapTimerControlButton
        case setDefaultTime
        case enterBackground
    }

    enum CancelID { case timer }
    
    enum TimerState {
        case stop
        case play
    }

    @Dependency(\.continuousClock) var clock

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.currentSeconds = state.defaultTime
                return .none
            case .onDisappear:
                return .cancel(id: CancelID.timer)
            case .timerTick:
                if state.currentSeconds <= 0 {
                    return .cancel(id: CancelID.timer)
                }

                state.currentSeconds -= 1
                return .none
            case .didTapReset:
                state.currentSeconds = state.defaultTime
                state.timerState = .play
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
            case .stopTimer:
                state.timerState = .stop
                return .cancel(id: CancelID.timer)
            case .startTimer:
                state.timerState = .play
                return .run { send in
                    while true {
                        try await Task.sleep(for: .seconds(1))
                        await send(.timerTick)
                    }
                }
                .cancellable(id: CancelID.timer)
            case .didTapTimerControlButton:
                switch state.timerState {
                case .stop:
                    return .send(.startTimer)
                case .play:
                    return .send(.stopTimer)
                }
            case .setDefaultTime:
                state.currentSeconds = state.defaultTime
                return .cancel(id: CancelID.timer)
            case .enterBackground:
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
                HStack(spacing: 0) {
                    Text("휴식")
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                        .foregroundStyle(.white100)
                        .padding(.trailing, 8.0)
                    Text("\(store.state.currentSeconds) 초")
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 28.0))
                        .foregroundStyle(.white100)
                    
                    Spacer()
                    
                    Button(action: {
                        store.send(.didTapReset)
                    }, label: {
                        Images.icRefresh24.swiftUIImage
                    })
                    .frame(width: 40.0, height: 40.0)
                    .padding(.trailing, 5.0)
                    
                    Button(action: {
                        store.send(.didTapTimerControlButton)
                    }, label: {
                        store.timerState == .play ? Images.icPause24.swiftUIImage : Images.icPlay24.swiftUIImage
                    })
                    .frame(width: 40.0, height: 40.0)
                }
                .padding(20.0)
                .background(.blue60)
                .clipShape(.rect(cornerRadius: 16.0))
            }
            .padding(10.0)
            .background(.clear)
            .onAppear {
                store.send(.onAppear)
            }
            .onDisappear {
                store.send(.onDisappear)
            }
        }
    }

}

#Preview {
    BreakTimerView(store: Store(initialState: BreakTimerFeature.State()) {
        BreakTimerFeature()
    })
}
