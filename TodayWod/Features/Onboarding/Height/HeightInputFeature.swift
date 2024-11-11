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
        var height: String = ""
        var onboardingUserModel: OnboardingUserInfoModel

        var isButtonEnabled: Bool = false
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
        case saveData(String)
    }

    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                if let savedHeight = state.onboardingUserModel.height {
                    state.height = String(savedHeight)
                }
                state.focusedField = .height
                return .none
            case .didTapBackButton:
                return .concatenate(
                    .send(.saveData(state.height)),
                    .run { _ in await dismiss() }
                )
            case .didTapNextButton:
                state.onboardingUserModel.height = Int(state.height)
                return .send(.finishInputHeight(WeightInputFeature.State(onboardingUserModel: state.onboardingUserModel)))
            case let .setHeight(height):
                state.height = height
                state.isButtonEnabled = state.height.isValidHeightWeight()
                return .none
            case .finishInputHeight:
                return .none
            case .binding:
                return .none
            case .saveData:
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
                            Text(Constants.title)
                                .font(Fonts.Pretendard.bold.swiftUIFont(size: 24.0))
                                .foregroundStyle(.grey100)
                                .lineLimit(2)
                            Spacer()
                        }
                        .padding(.top, 10.0)
                        .padding(.horizontal, 20.0)
                        
                        HStack {
                            Text(Constants.subTitle)
                                .font(Fonts.Pretendard.regular.swiftUIFont(size: 20.0))
                                .foregroundStyle(.grey80)
                                .lineLimit(1)
                            
                            Spacer()
                        }
                        .padding(.top, 16.0)
                        .padding(.horizontal, 20)
                        
                        HStack(spacing: 8) {
                            TextField(Constants.placeHolder, text: $store.height.sending(\.setHeight))
                                .focused($focusedField, equals: .height)
                                .autocorrectionDisabled()
                                .keyboardType(.numberPad)
                                .font(Fonts.Pretendard.medium.swiftUIFont(size: 56.0))
                                .foregroundStyle(.grey100)
                                .padding(.vertical, 8)
                                .fixedSize(horizontal: true, vertical: false)
                                .onChange(of: store.height) { newValue in // TODO: - onChange 경우 Copy & Paste 처리 불가
                                    store.send(.setHeight(newValue.filteredHeightWeight()))
                                }
                            
                            Text(Constants.unit)
                                .font(Fonts.Pretendard.medium.swiftUIFont(size: 24.0))
                                .foregroundStyle(.grey100)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 48.0)
                        .padding(.horizontal, 20.0)
                    }
                }
                Spacer()
                BottomButton(title: Constants.buttonTitle) {
                    store.send(.didTapNextButton)
                }
                .disabled(!store.isButtonEnabled)
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

private extension HeightInputView {

    enum Constants {
        static let title: String = "나만의 운동 프로그램을\n설정할게요!"
        static let subTitle: String = "키(cm) 를 알려주세요."
        static let placeHolder: String = "0"
        static let buttonTitle: String = "다음"
        static let unit: String = "cm"
    }

}

#Preview {
    HeightInputView(store: Store(initialState: HeightInputFeature.State(onboardingUserModel: .init())) {
        HeightInputFeature()
    })
}
