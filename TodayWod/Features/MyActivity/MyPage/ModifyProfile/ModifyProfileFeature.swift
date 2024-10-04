//
//  ModifyProfileFeature.swift
//  TodayWod
//
//  Created by Davidyoon on 9/27/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ModifyProfileFeature {
    
    @ObservableState
    struct State: Equatable {
        var placeHolder: String = ""
        var nickName: String = ""
        var isValidNickname: Bool = false
        let ruleDescription: String = "영어와 한글, 숫자 2~10자 이내"
        let validNicknameMessage: String = "멋진 닉네임이에요!"
        var focusedField: FieldType?
        var onboardingUserInfoModel: OnboardingUserInfoModel
        
        enum FieldType: Hashable {
            case nickName
        }
    }
    
    enum Action: BindableAction {
        case onAppear
        case didTapBackButton
        case didTapConfirmButton
        case setNickname(String)
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.placeHolder = state.onboardingUserInfoModel.nickName ?? ""
                state.focusedField = .nickName
                return .none
            case .didTapBackButton:
                return .run { _ in await dismiss() }
            case .didTapConfirmButton:
                UserDefaultsManager().saveOnboardingUserInfo(data: state.onboardingUserInfoModel)
                
                return .run { _ in await dismiss() }
            case .binding:
                return .none
            case let .setNickname(nickname):
                state.nickName = nickname
                state.onboardingUserInfoModel.nickName = nickname
                state.isValidNickname = nickname.isValidNickName()
                return .none
            }
        }
    }
    
}

import SwiftUI

struct ModifyProfileView: View {
    
    @Perception.Bindable var store: StoreOf<ModifyProfileFeature>
    @FocusState var focusedField: ModifyProfileFeature.State.FieldType?
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                CustomNavigationView {
                    store.send(.didTapBackButton)
                }
                ScrollView {
                    HStack {
                        TextField(store.placeHolder, text: $store.nickName.sending(\.setNickname))
                            .focused($focusedField, equals: .nickName)
                            .autocorrectionDisabled()
                            .font(Fonts.Pretendard.medium.swiftUIFont(size: 24.0))
                            .foregroundStyle(.grey100)
                            .multilineTextAlignment(.center)
                            .onChange(of: store.nickName) { newValue in
                                store.send(.setNickname(newValue.nickNameFilter()))
                            }
                    }
                    .frame(height: 48.0)
                    .padding(.top, 100.0)
                    .padding(.horizontal, 20.0)
                    
                    HStack {
                        Text(store.isValidNickname ? store.validNicknameMessage : store.ruleDescription)
                            .multilineTextAlignment(.center)
                            .font(Fonts.Pretendard.regular.swiftUIFont(size: 13.0))
                            .foregroundStyle(store.isValidNickname ? Colors.green10.swiftUIColor : .grey80)
                    }
                    .padding(.top, 8.0)
                }
                
                Spacer()
                
                BottomButton(title: "확인") {
                    store.send(.didTapConfirmButton)
                }
                .disabled(!store.isValidNickname)
                .padding(.horizontal, 38.0)
                .padding(.bottom, 20.0)
            }
            .onAppear {
                store.send(.onAppear)
            }
            .bind($store.focusedField, to: $focusedField)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
}

#Preview {
    ModifyProfileView(store: Store(initialState: ModifyProfileFeature.State( onboardingUserInfoModel: .preview)) {
        ModifyProfileFeature()
    })
}
