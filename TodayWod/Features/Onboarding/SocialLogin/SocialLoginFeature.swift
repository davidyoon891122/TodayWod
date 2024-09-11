//
//  SocialLoginFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/9/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SocialLoginFeature {

    @ObservableState
    struct State: Equatable {
        let title: String = "todaywod"
        @Presents var alert: AlertState<Action.Alert>?
    }

    enum Action {
        case alert(PresentationAction<Alert>)
        case didTapAppleLogin
        case didTapGoogleLogin
        case didTapKakaoLogin

        enum Alert: Equatable {

        }
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .alert:
                return .none
            case .didTapAppleLogin:
                let userDefaultsManager = UserDefaultsManager()
                userDefaultsManager.saveUserInfo(data: .appleFake)

                state.alert = AlertState {
                    TextState("Login Completed")
                }

                return .none
            case .didTapGoogleLogin:
                let userDefaultsManager = UserDefaultsManager()
                userDefaultsManager.saveUserInfo(data: .googleFake)

                state.alert = AlertState {
                    TextState("Login Completed")
                }

                return .none
            case .didTapKakaoLogin:
                let userDefaultsManager = UserDefaultsManager()
                userDefaultsManager.saveUserInfo(data: .kakaoFake)

                state.alert = AlertState {
                    TextState("Login Completed")
                }
                return .none
            }
        }
        .ifLet(\.alert, action: \.alert)
    }

}

import SwiftUI

struct SocialLoginView: View {

    @Perception.Bindable var store: StoreOf<SocialLoginFeature>

    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text(store.title)
                    .bold()
                    .font(.system(size: 26.0))
                    .foregroundStyle(.white)
                    .padding(.top, 179)

                Text("매일 매일 운동 와드를 손쉽게!")
                    .bold()
                    .font(.system(size: 18.0))
                    .foregroundStyle(.white)
                    .padding(.top, 39)
                Spacer()

                Button(action: {
                    store.send(.didTapKakaoLogin)
                }, label: {
                    ZStack {
                        Text("카카오톡으로 시작하기")
                            .bold()
                            .font(.system(size: 14.0))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.black)

                        Rectangle()
                            .foregroundStyle(.gray)
                            .frame(width: 24.0, height: 24.0)
                            .position(x: 32.0, y: 56.0 / 2)
                    }
                })
                .frame(maxWidth: .infinity, maxHeight: 56.0)
                .background(.white)
                .clipShape(.rect(cornerRadius: 30))
                .padding(.horizontal, 38)

                Button(action: {
                    store.send(.didTapGoogleLogin)
                }, label: {
                    ZStack {
                        Text("Google로 시작하기")
                            .bold()
                            .font(.system(size: 14.0))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.black)

                        Rectangle()
                            .foregroundStyle(.gray)
                            .frame(width: 24.0, height: 24.0)
                            .position(x: 32.0, y: 56.0 / 2)
                    }
                })
                .frame(maxWidth: .infinity, maxHeight: 56.0)
                .background(.white)
                .clipShape(.rect(cornerRadius: 30))
                .padding(.horizontal, 38)

                Button(action: {
                    store.send(.didTapAppleLogin)
                }, label: {
                    ZStack {
                        Text("Apple로 시작하기")
                            .bold()
                            .font(.system(size: 14.0))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.black)

                        Rectangle()
                            .foregroundStyle(.gray)
                            .frame(width: 24.0, height: 24.0)
                            .position(x: 32.0, y: 56.0 / 2)
                    }
                })
                .frame(maxWidth: .infinity, maxHeight: 56.0)
                .background(.white)
                .clipShape(.rect(cornerRadius: 30))
                .padding(.horizontal, 38)
                .padding(.bottom, 85)
            }
            .alert($store.scope(state: \.alert, action: \.alert))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Colors.splashBackground.swiftUIColor)
        }
    }
}

#Preview {
    SocialLoginView(store: Store(initialState: SocialLoginFeature.State()) {
        SocialLoginFeature()
    })
}
