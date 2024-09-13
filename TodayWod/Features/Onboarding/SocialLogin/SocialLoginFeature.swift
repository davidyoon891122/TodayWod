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
        var path = StackState<AppFeature.State>()
    }

    enum Action {
        case alert(PresentationAction<Alert>)
        case didTapAppleLogin
        case didTapGoogleLogin
        case didTapKakaoLogin
        case path(StackAction<AppFeature.State, AppFeature.Action>)
        @CasePathable
        enum Alert: Equatable {
            case moveToTabView(UserInfoModel)
        }
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .alert(.presented(.moveToTabView(let userModel))):
                let userDefaulsManager = UserDefaultsManager()
                userDefaulsManager.saveUserInfo(data: userModel)
                
                state.path.append(AppFeature.State())
                return .none
            case .alert:
                return .none
            case .didTapAppleLogin:
                state.alert = AlertState {
                    TextState("Login Completed")
                } actions: {
                    ButtonState(role: .cancel, action: .send(.moveToTabView(.appleFake))) {
                        TextState("Yes")
                    }
                }
                return .none
            case .didTapGoogleLogin:
                state.alert = AlertState {
                    TextState("Login Completed")
                } actions: {
                    ButtonState(role: .cancel, action: .send(.moveToTabView(.googleFake))) {
                        TextState("Yes")
                    }
                }
                return .none
            case .didTapKakaoLogin:
                state.alert = AlertState {
                    TextState("Login Completed")
                } actions: {
                    ButtonState(role: .cancel, action: .send(.moveToTabView(.kakaoFake))) {
                        TextState("Yes")
                    }
                }
                return .none
            case .path(_):
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
        .forEach(\.path, action: \.path) {
            AppFeature()
        }
    }

}

import SwiftUI

struct SocialLoginView: View {

    @Perception.Bindable var store: StoreOf<SocialLoginFeature>

    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
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
            } destination: { store in
                ContentView(store: store)
            }
        }
    }
}

#Preview {
    SocialLoginView(store: Store(initialState: SocialLoginFeature.State()) {
        SocialLoginFeature()
    })
}
