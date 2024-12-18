//
//  WeightInputFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/16/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct WeightInputFeature {

    @ObservableState
    struct State: Equatable {
        var weight: String = ""
        var onboardingUserModel: OnboardingUserInfoModel
        var focusedField: FieldType?

        var isButtonEnabled: Bool = false

        enum FieldType: Hashable {
            case weight
        }
    }

    enum Action: BindableAction {
        case onAppear
        case didTapBackButton
        case didTapNextButton
        case setWeight(String)
        case finishInputWeight(LevelSelectFeature.State)
        case binding(BindingAction<State>)
        case saveData(String)
    }

    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                if let savedWeight = state.onboardingUserModel.weight {
                    state.weight = String(savedWeight)
                }
                state.focusedField = .weight
                return .none
            case .didTapBackButton:
                return .concatenate(
                    .send(.saveData(state.weight)),
                    .run { _ in await dismiss() }
                )
            case .didTapNextButton:
                state.onboardingUserModel.weight = Int(state.weight)
                return .send(.finishInputWeight(LevelSelectFeature.State(onboardingUserModel: state.onboardingUserModel)))
            case let .setWeight(weight):
                state.weight = weight
                state.isButtonEnabled = state.weight.isValidHeightWeight()
                return .none
            case .finishInputWeight:
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

struct WeightInputView: View {

    @Perception.Bindable var store: StoreOf<WeightInputFeature>
    @FocusState var focusedField: WeightInputFeature.State.FieldType?

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
                        
                        HStack(spacing: 8.0) {
                            TextField(Constants.placeHolder, text: $store.weight.sending(\.setWeight))
                                .focused($focusedField, equals: .weight)
                                .autocorrectionDisabled()
                                .keyboardType(.numberPad)
                                .font(Fonts.Pretendard.medium.swiftUIFont(size: 56.0))
                                .foregroundStyle(.grey100)
                                .padding(.vertical, 8.0)
                                .fixedSize(horizontal: true, vertical: false)
                                .onChange(of: store.weight) { newValue in
                                    store.send(.setWeight(newValue.filteredHeightWeight()))
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

private extension WeightInputView {

    enum Constants {
        static let title: String = "나만의 운동 프로그램을\n설정할게요!"
        static let subTitle: String = "몸무게(kg) 를 알려주세요."
        static let placeHolder: String = "0"
        static let buttonTitle: String = "다음"
        static let unit: String = "kg"
    }

}

#Preview {
    WeightInputView(store: Store(initialState: WeightInputFeature.State(onboardingUserModel: .init())) {
        WeightInputFeature()
    })
}
