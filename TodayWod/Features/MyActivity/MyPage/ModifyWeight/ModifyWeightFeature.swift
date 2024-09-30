//
//  ModifyWeightFeature.swift
//  TodayWod
//
//  Created by Davidyoon on 9/27/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ModifyWeightFeature {
    
    @ObservableState
    struct State: Equatable {
        var placeHolder: String = "0"
        var weight: String = ""
        var isValidWeight: Bool = false
        let buttonTitle: String = "확인"
        var onboardingUserInfoModel = UserDefaultsManager().loadOnboardingUserInfo()
        var focusedField: FieldType?
        
        enum FieldType: Hashable {
            case weight
        }
    }
    
    enum Action: BindableAction {
        case onAppear
        case setWeight(String)
        case binding(BindingAction<State>)
        case didTapBackButton
        case didTapConfirmButton
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.placeHolder = String(state.onboardingUserInfoModel?.weight ?? 0)
                state.focusedField = .weight
                return .none
            case let .setWeight(weight):
                if let _ = Int(weight), !weight.isEmpty {
                    state.weight = weight
                    state.isValidWeight = true
                } else {
                    state.weight = ""
                    state.isValidWeight = false
                }
                return .none
            case .binding:
                return .none
            case .didTapBackButton:
                return .run { _ in await dismiss() }
            case .didTapConfirmButton:
                guard var onboardingUserInfoModel = state.onboardingUserInfoModel else { return .none }
                onboardingUserInfoModel.weight = Int(state.weight)
                UserDefaultsManager().saveOnboardingUserInfo(data: onboardingUserInfoModel)

                return .run { _ in await dismiss() }
            }
        }
    }
    
}

import SwiftUI

struct ModifyWeightView: View {
    
    @Perception.Bindable var store: StoreOf<ModifyWeightFeature>
    @FocusState var focusedField: ModifyWeightFeature.State.FieldType?
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                CustomNavigationView {
                    store.send(.didTapBackButton)
                }
                ScrollView {
                    HStack(spacing: 8) {
                        TextField(store.placeHolder, text: $store.weight.sending(\.setWeight))
                            .focused($focusedField, equals: .weight)
                            .multilineTextAlignment(.trailing)
                            .autocorrectionDisabled()
                            .keyboardType(.numberPad)
                            .font(Fonts.Pretendard.medium.swiftUIFont(size: 56.0))
                            .foregroundStyle(.grey100)
                            .padding(.vertical, 8)
                            .fixedSize(horizontal: true, vertical: false)
                        
                        Text("kg")
                            .font(Fonts.Pretendard.medium.swiftUIFont(size: 24.0))
                            .foregroundStyle(.grey100)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 20.0)
                    .padding(.top, 100.0)
                }
                Spacer()
                Button(action: {
                    store.send(.didTapConfirmButton)
                }, label: {
                    Text(store.state.buttonTitle)
                        .nextButtonStyle()
                })
                .disabled(!store.isValidWeight)
                .padding(.horizontal, 38.0)
                .padding(.bottom, 20.0)
            }
            .bind($store.focusedField, to: $focusedField)
            .onAppear {
                store.send(.onAppear)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
}

#Preview {
    ModifyWeightView(store: Store(initialState: ModifyWeightFeature.State()) {
        ModifyWeightFeature()
    })
}
