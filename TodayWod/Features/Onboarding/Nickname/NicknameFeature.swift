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
        var focusedField: FieldType?

        enum FieldType: Hashable {
            case nickName
        }
    }
    
    enum Action: BindableAction {
        case onAppear
        case setNickname(String)
        case didTapNextButton
        case didTapBackButton
        case saveDataBeforeDismiss(String)
        case finishInputNickname(HeightInputFeature.State)
        case binding(BindingAction<State>)
    }

    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.nickName = state.onboardingUserModel.nickName ?? ""
                state.focusedField = .nickName
                return .none
            case let .setNickname(nickName):
                state.nickName = nickName
                state.isValidNickname = nickName.isValidNickName()
                return .none
            case .didTapNextButton:
                state.onboardingUserModel.nickName = state.nickName
                return .send(.finishInputNickname(HeightInputFeature.State(onboardingUserModel: state.onboardingUserModel)))
            case .didTapBackButton:

                return .merge(
                    .send(.saveDataBeforeDismiss(state.nickName)),
                    .run { _ in await dismiss() }
                )
            case .finishInputNickname:
                return .none
            case .binding:
                return .none
            case .saveDataBeforeDismiss:
                return .none
            }
        }
    }

}

import SwiftUI

struct NicknameInputView: View {

    @Perception.Bindable var store: StoreOf<NicknameFeature>
    @FocusState var focusedField: NicknameFeature.State.FieldType?

    var body: some View {
        WithPerceptionTracking {
            VStack {
                CustomNavigationView {
                    store.send(.didTapBackButton)
                }
                ScrollView {
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
                                .focused($focusedField, equals: .nickName)
                                .multilineTextAlignment(.center)
                                .autocorrectionDisabled()
                                .font(Fonts.Pretendard.medium.swiftUIFont(size: 24.0))
                                .foregroundStyle(.grey100)
                                .padding(.vertical, 8)
                                .onChange(of: store.nickName) { newValue in
                                    store.send(.setNickname(newValue.filteredNickName()))
                                }
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
                    }
                }
                Spacer()
                BottomButton(title: store.buttonTitle) {
                    store.send(.didTapNextButton)
                }
                .disabled(!store.isValidNickname)
                .padding(.bottom, 20.0)
                .padding(.horizontal, 38.0)
            }
            .bind($store.focusedField, to: $focusedField)
            .toolbar(.hidden, for: .navigationBar)
            .onAppear {
                store.send(.onAppear)
            }
        }

    }
}

#Preview {
    NicknameInputView(store: Store(initialState: NicknameFeature.State(onboardingUserModel: .init())) {
        NicknameFeature()
    })
}
