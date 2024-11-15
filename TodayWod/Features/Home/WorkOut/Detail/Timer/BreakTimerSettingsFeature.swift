//
//  BreakTimerSettingsFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 10/27/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct BreakTimerSettingsFeature {

    @ObservableState
    struct State: Equatable {
        @Shared(.appStorage(SharedConstants.breakTime)) var currentTime: Int = 60
        let recommendTimes: [Int] = [30, 60, 90, 120]
        let maxTime: Int = 300
        let minTime: Int = 10
    }

    enum Action {
        case didTapMinusButton
        case didTapPlusButton
        case didTapRecommend(Int)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapMinusButton:
                if state.currentTime > state.minTime { // min 값 확인필요
                    state.currentTime -= 10
                }
                return .none
            case .didTapPlusButton:
                if state.currentTime < state.maxTime {
                    state.currentTime += 10
                }
                return .none
            case .didTapRecommend(let time):
                state.currentTime = time
                return .none
            }
        }
    }

}

import SwiftUI
struct BreakTimerSettingsView: View {

    let store: StoreOf<BreakTimerSettingsFeature>

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20.0) {
                Text("휴식 타이머")
                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                    .foregroundStyle(.grey100)

                HStack(spacing: 10.0) {
                    Text("\(store.state.currentTime)초")
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 28.0))
                        .foregroundStyle(.grey100)
                    Spacer()

                    Button(action: {
                        store.send(.didTapMinusButton)
                    }, label: {
                        Text("-10초")
                            .font(Fonts.Pretendard.bold.swiftUIFont(size: 13.0))
                            .frame(width: 64.0, height: 38.0)
                            .overlay {
                                RoundedRectangle(cornerRadius: 4.0)
                                    .stroke(.grey60)
                            }
                            .tint(.grey100)
                    })

                    Button(action: {
                        store.send(.didTapPlusButton)
                    }, label: {
                        Text("+10초")
                            .font(Fonts.Pretendard.bold.swiftUIFont(size: 13.0))
                            .frame(width: 64.0, height: 38.0)
                            .overlay {
                                RoundedRectangle(cornerRadius: 4.0)
                                    .stroke(.grey60)
                            }
                            .tint(.grey100)
                    })
                }

                VStack(alignment: .leading, spacing: 10.0) {
                    Text("추천 휴식 시간")
                        .font(Fonts.Pretendard.regular.swiftUIFont(size: 13.0))
                        .foregroundStyle(.grey80)
                    HStack(spacing: 6.0) {
                        ForEach(store.state.recommendTimes, id: \.self) { time in
                            Button(action: {
                                store.send(.didTapRecommend(time))
                            }, label: {
                                Text("\(time)초")
                                    .font(Fonts.Pretendard.regular.swiftUIFont(size: 13.0))
                                    .tint(.grey80)
                                    .frame(width: 59.0, height: 34.0)
                                    .background(.grey20)
                                    .clipShape(.rect(cornerRadius: 300))
                            })
                        }
                    }
                }
            }
            .padding(20.0)
            .background(.white)
            .clipShape(.rect(cornerRadius: 12.0))
        }
        .padding(10.0)
    }

}

#Preview {
    BreakTimerSettingsView(store: Store(initialState: BreakTimerSettingsFeature.State()) {
        BreakTimerSettingsFeature()
    })
}
