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
        let title: String = "나만의 운동 프로그램을\n설정할게요!"
        let subTitle: String = "몸무게(kg) 를 알려주세요."
        var weight: String = ""
        let placeHolder: String = "0"
        let buttonTitle: String = "다음"
        var onboardingUserModel: OnboardingUserInfoModel

        var isValidWeight: Bool = false
        @Presents var levelSelectState: LevelSelectFeature.State?

    }

    enum Action {
        case didTapBackButton
        case didTapNextButton
        case setWeight(String)
        case levelSelect(PresentationAction<LevelSelectFeature.Action>)
    }

    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapBackButton:
                return .run { _ in await dismiss() }
            case .didTapNextButton:
                state.onboardingUserModel.weight = Int(state.weight)
                state.levelSelectState = LevelSelectFeature.State(onboardingUserModel: state.onboardingUserModel)

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
            case .levelSelect:
                return .none
            }
        }
        .ifLet(\.$levelSelectState, action: \.levelSelect) {
            LevelSelectFeature()
        }
    }

}

import SwiftUI

struct WeightInputView: View {

    @Perception.Bindable var store: StoreOf<WeightInputFeature>

    var body: some View {
        WithPerceptionTracking {
            VStack {
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

                    HStack(spacing: 8) {
                        TextField(store.placeHolder, text: $store.weight.sending(\.setWeight))
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
                    .padding(.top, 48.0)
                    .padding(.horizontal, 20.0)

                    Button(action: {
                        store.send(.didTapNextButton)
                    }, label: {
                        Text(store.buttonTitle)
                            .nextButtonStyle()
                    })
                    .disabled(!store.isValidWeight)
                    .padding(.top, 91.0)
                    .padding(.horizontal, 38.0)

                    Spacer()
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(item: $store.scope(state: \.levelSelectState, action: \.levelSelect)) { store in
                LevelSelectView(store: store)
            }
        }
    }

}

#Preview {
    WeightInputView(store: Store(initialState: WeightInputFeature.State(onboardingUserModel: .init())) {
        WeightInputFeature()
    })
}
