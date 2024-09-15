//
//  NicknameFeature.swift
//  TodayWod
//
//  Created by Davidyoon on 9/12/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct NicknameFeature {
    
    @ObservableState
    struct State: Equatable {
        let title: String = "나만의 운동 프로그램을\n설정할게요!"
        let subTitle: String = "닉네임을 입력하세요."
        let placeHolder: String = "닉네임"
        let ruleDescription: String = "영어와 한글, 숫자 2~10자 이내"
        let validNicknameMessage: String = "멋진 닉네임이에요!"
        let buttonTitle: String = "다음"
        var nickName: String = ""
        var isValidNickname: Bool = false
        var onboardingUserModel: OnboardingUserInfoModel
    }
    
    enum Action {
        case setNickname(String)
        case didTapNextButton
        case didTapBackButton
    }

    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .setNickname(nickName):
                state.nickName = nickName
                state.isValidNickname = isValidNickName(input: nickName)

                return .none
            case .didTapNextButton:

                return .none
            case .didTapBackButton:
                return .run { _ in await dismiss() }
            }
        }
    }

    func isValidNickName(input: String) -> Bool {
        let regex = "^[a-zA-Z가-힣0-9]{2,10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

        return predicate.evaluate(with: input)
    }

}

import SwiftUI

struct NicknameInputView: View {

    @Perception.Bindable var store: StoreOf<NicknameFeature>

    var body: some View {
        WithPerceptionTracking {
            CustomNavigationView {
                store.send(.didTapBackButton)
            }
            VStack {
                HStack {
                    Text(store.title)
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 24.0))
                        .foregroundStyle(.grey100)
                        .lineLimit(2)
                    Spacer()
                }
                .padding(.top, 10.0)
                .padding(.horizontal, 20.0)

                HStack {
                    Text(store.subTitle)
                        .font(Fonts.Pretendard.regular.swiftUIFont(size: 20.0))
                        .foregroundStyle(.grey80)
                        .lineLimit(1)

                    Spacer()
                }
                .padding(.top, 16.0)
                .padding(.horizontal, 20)

                HStack {
                    TextField(store.placeHolder, text: $store.nickName.sending(\.setNickname))
                        .multilineTextAlignment(.center)
                        .font(Fonts.Pretendard.medium.swiftUIFont(size: 24.0))
                        .foregroundStyle(.grey100)
                        .padding(.vertical, 8)
                }
                .frame(height: 48.0)
                .padding(.top, 40.0)
                .padding(.horizontal, 20.0)

                HStack {
                    Text(store.isValidNickname ? store.validNicknameMessage : store.ruleDescription)
                        .multilineTextAlignment(.center)
                        .font(Fonts.Pretendard.regular.swiftUIFont(size: 13.0))
                        .foregroundStyle(store.isValidNickname ? Colors.green10.swiftUIColor : .grey80)
                }

                Button(action: {

                }, label: {
                    Text(store.buttonTitle)
                        .nextButtonStyle()
                })
                .disabled(!store.isValidNickname)
                .padding(.top, 91.0)
                .padding(.horizontal, 38.0)

                Spacer()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NicknameInputView(store: Store(initialState: NicknameFeature.State(onboardingUserModel: .init())) {
        NicknameFeature()
    })
}
