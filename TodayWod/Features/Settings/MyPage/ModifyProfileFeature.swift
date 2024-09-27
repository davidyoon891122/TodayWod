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
        var placeHolder: String
        var nickName: String = ""
        var isValidNickname: Bool = false
        let ruleDescription: String = "영어와 한글, 숫자 2~10자 이내"
        let validNicknameMessage: String = "멋진 닉네임이에요!"
    }
    
    enum Action: BindableAction {
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
            case .didTapBackButton:
                return .run { _ in await dismiss() }
            case .didTapConfirmButton:
                // TODO: - 변경된 닉네임 저장 후 화면 닫기
                return .run { _ in await dismiss() }
            case .binding:
                return .none
            case let .setNickname(nickname):
                state.nickName = nickname
                state.isValidNickname = isValidNickName(input: nickname)
                return .none
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

struct ModifyProfileView: View {
    
    @Perception.Bindable var store: StoreOf<ModifyProfileFeature>
    
    var body: some View {
        VStack {
            CustomNavigationView {
                store.send(.didTapBackButton)
            }
            HStack {
                TextField(store.placeHolder, text: $store.nickName.sending(\.setNickname))
                    .autocorrectionDisabled()
                    .font(Fonts.Pretendard.medium.swiftUIFont(size: 24.0))
                    .foregroundStyle(.grey100)
                    .multilineTextAlignment(.center)
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
            
            Spacer()
            
            Button(action: {
                store.send(.didTapConfirmButton)
            }, label: {
                Text("확인")
                    .nextButtonStyle() // TODO: - 범용적인 이름으로 바꿀지 고민
            })
            .disabled(!store.isValidNickname)
            .padding(.horizontal, 38.0)
            .padding(.bottom, 20.0)

        }
    }
    
}

#Preview {
    ModifyProfileView(store: Store(initialState: ModifyProfileFeature.State(placeHolder: "Nickname")) {
        ModifyProfileFeature()
    })
}
