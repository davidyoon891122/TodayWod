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
        var currentTime: Int = 60
        let recommendTimes: [Int] = [30, 60, 90, 120]
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
                if state.currentTime >= 10 {
                    state.currentTime -= 10
                }
                return .none
            case .didTapPlusButton:
                state.currentTime += 10
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
            Rectangle()
                .frame(width: 32.0, height: 4.0)
                .foregroundStyle(.blue40)
                .padding(.top, 8.0)

            VStack(alignment: .leading) {

                Text("휴식 타이머")
                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                    .padding(.top, 20.0)
                    .padding(.leading, 20.0)

                HStack(spacing: 10.0) {
                    Text("\(store.state.currentTime)초")
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 24.0))
                    Spacer()

                    Button(action: {
                        store.send(.didTapMinusButton)
                    }, label: {
                        Text("-10초")
                            .font(Fonts.Pretendard.bold.swiftUIFont(size: 13.0))
                            .frame(width: 64.0, height: 38.0)
                            .overlay {
                                RoundedRectangle(cornerRadius: 4.0)
                                    .stroke(.grey40)
                            }
                            .tint(.grey90)
                    })

                    Button(action: {
                        store.send(.didTapPlusButton)
                    }, label: {
                        Text("+10초")
                            .font(Fonts.Pretendard.bold.swiftUIFont(size: 13.0))
                            .frame(width: 64.0, height: 38.0)
                            .overlay {
                                RoundedRectangle(cornerRadius: 4.0)
                                    .stroke(.grey40)
                            }
                            .tint(.grey90)
                    })
                }
                .padding(.top, 20.0)
                .padding(.horizontal, 20.0)

                VStack(alignment: .leading) {
                    Text("추천 휴식 시간")
                        .font(Fonts.Pretendard.regular.swiftUIFont(size: 13.0))
                    HStack(spacing: 17.0) {
                        ForEach(store.state.recommendTimes, id: \.self) { time in
                            Button(action: {
                                store.send(.didTapRecommend(time))
                            }, label: {
                                Text("\(time)초")
                                    .font(Fonts.Pretendard.regular.swiftUIFont(size: 13.0))
                                    .tint(.grey90)
                                    .frame(width: 56.0, height: 30.0)
                                    .background(.grey20)
                                    .clipShape(.rect(cornerRadius: 300))

                            })
                        }
                    }
                    .padding(.top, 10.0)
                }
                .padding(.top, 26.0)
                .padding(.horizontal, 20.0)
                .padding(.bottom, 20.0)
            }
            .background(.white)
            .clipShape(.rect(cornerRadius: 12.0))
            .padding(.horizontal, 20.0)
            .padding(.top, 10.0)
            .padding(.bottom, 20.0)
        }
        .background(.blue20)
    }

}

#Preview {
    BreakTimerSettingsView(store: Store(initialState: BreakTimerSettingsFeature.State()) {
        BreakTimerSettingsFeature()
    })
}
