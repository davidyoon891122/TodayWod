//
//  HeightInputFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/15/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct HeightInputFeature {

    @ObservableState
    struct State: Equatable {
        let title: String = "나만의 운동 프로그램을\n설정할게요!"
        let subTitle: String = "키(cm) 를 알려주세요."
        var height: String = ""
        let placeHolder: String = "0"
        let buttonTitle: String = "다음"
        var onboardingUserModel: OnboardingUserInfoModel

        var isValidHeight: Bool = false
        var focusedField: FieldType?

        enum FieldType: Hashable {
            case height
        }
    }

    enum Action: BindableAction {
        case onAppear
        case didTapBackButton
        case didTapNextButton
        case setHeight(String)
        case finishInputHeight(WeightInputFeature.State)
        case binding(BindingAction<State>)
    }

    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.focusedField = .height
                return .none
            case .didTapBackButton:
                
                return .run { _ in await dismiss() }
            case .didTapNextButton:
                state.onboardingUserModel.height = Int(state.height)
                return .send(.finishInputHeight(WeightInputFeature.State(onboardingUserModel: state.onboardingUserModel)))
            case let .setHeight(height):
                if let _ = Int(height), !height.isEmpty {
                    state.height = height
                    state.isValidHeight = true
                } else {
                    state.height = ""
                    state.isValidHeight = false
                }
                return .none
            case .finishInputHeight:
                return .none
            case .binding:
                return .none
            }
        }
    }

}

import SwiftUI

struct HeightInputView: View {

    @Perception.Bindable var store: StoreOf<HeightInputFeature>
    @FocusState var focusedField: HeightInputFeature.State.FieldType?

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
                        
                        HStack(spacing: 8) {
                            TextField(store.placeHolder, text: $store.height.sending(\.setHeight))
                                .focused($focusedField, equals: .height)
                                .multilineTextAlignment(.trailing)
                                .autocorrectionDisabled()
                                .keyboardType(.numberPad)
                                .font(Fonts.Pretendard.medium.swiftUIFont(size: 56.0))
                                .foregroundStyle(.grey100)
                                .padding(.vertical, 8)
                                .fixedSize(horizontal: true, vertical: false)
                            
                            Text("cm")
                                .font(Fonts.Pretendard.medium.swiftUIFont(size: 24.0))
                                .foregroundStyle(.grey100)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 48.0)
                        .padding(.horizontal, 20.0)
                    }
                }
                Spacer()
                BottomButton(title: store.buttonTitle) {
                    store.send(.didTapNextButton)
                }
                .disabled(!store.isValidHeight)
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
    HeightInputView(store: Store(initialState: HeightInputFeature.State(onboardingUserModel: .init())) {
        HeightInputFeature()
    })
}
