//
//  BreakTimerView.swift
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
        var currentSeconds: Int = 0
        var buttonState: ButtonState = .pause
    }
    
    enum Action {
        case breakTimerTick
        case didTapReset
        case didTapPause
        case didTapResume
        case setButtonState
    }
    
    enum ButtonState {
        case pause
        case resume
    }
    
    enum CancelID {
        case breakTimer
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .breakTimerTick:
                if state.currentSeconds <= 0 {
                    return .cancel(id: CancelID.breakTimer)
                }
                state.currentSeconds -= 1
                return .none
            case .didTapReset:
                state.currentSeconds = 60
                state.buttonState = .pause
                return .concatenate(
                    .cancel(id: CancelID.breakTimer),
                    .run { send in
                        while true {
                            try await Task.sleep(for: .seconds(1))
                            await send(.breakTimerTick)
                        }
                    }
                    .cancellable(id: CancelID.breakTimer)
                )
            case .didTapPause:
                return .cancel(id: CancelID.breakTimer)
            case .didTapResume:
                return .run { send in
                    while true {
                        try await Task.sleep(for: .seconds(1))
                        await send(.breakTimerTick)
                    }
                }
                .cancellable(id: CancelID.breakTimer)
            case .setButtonState:
                switch state.buttonState {
                case .pause:
                    state.buttonState = .resume
                    return .send(.didTapPause)
                case .resume:
                    state.buttonState = .pause
                    return .send(.didTapResume)
                }
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
                    
                    Text("\(store.state.currentSeconds) 초")
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 28.0))
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
                            Images.icPause24.swiftUIImage
                        } else {
                            Images.icPlay24.swiftUIImage
                        }
                        
                    })
                }
                .padding(.horizontal, 20.0)
                .padding(.vertical, 20.0)
                .background(.white)
                .clipShape(.rect(cornerRadius: 16.0))
            }
            .padding(20.0)
            .background(.blue20)

        }
    }

}

#Preview {
    BreakTimerView(store: Store(initialState: BreakTimerFeature.State()) {
        BreakTimerFeature()
    })
}
