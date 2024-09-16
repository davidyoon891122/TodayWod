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
        @Presents var weightInputState: WeightInputFeature.State?
    }

    enum Action {
        case didTapBackButton
        case didTapNextButton
        case setHeight(String)
        case weightInput(PresentationAction<WeightInputFeature.Action>)
    }

    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapBackButton:
                
                return .run { _ in await dismiss() }
            case .didTapNextButton:
                state.onboardingUserModel.height = Int(state.height)
                print(state.onboardingUserModel)
                // TODO: - 다음 navigation path 세팅 처리

                state.weightInputState = WeightInputFeature.State(onboardingUserModel: state.onboardingUserModel)
                return .none
            case let .setHeight(height):
                if let _ = Int(height), !height.isEmpty {
                    state.height = height
                    state.isValidHeight = true
                } else {
                    state.height = ""
                    state.isValidHeight = false
                }
                return .none
            case .weightInput:
                return .none
            }
        }
        .ifLet(\.$weightInputState, action: \.weightInput) {
            WeightInputFeature()
        }
    }

}

import SwiftUI

struct HeightInputView: View {

    @Perception.Bindable var store: StoreOf<HeightInputFeature>

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
                        TextField(store.placeHolder, text: $store.height.sending(\.setHeight))
                            .multilineTextAlignment(.trailing)
                            .autocorrectionDisabled()
                            .keyboardType(.numberPad)
                            .font(Fonts.Pretendard.medium.swiftUIFont(size: 56.0))
                            .foregroundStyle(.grey100)
                            .padding(.vertical, 8)
                            .fixedSize(horizontal: true, vertical: false) // Prevent horizontal expansion

                        Text("cm")
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
                    .disabled(!store.isValidHeight)
                    .padding(.top, 91.0)
                    .padding(.horizontal, 38.0)

                    Spacer()
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(item: $store.scope(state: \.weightInputState, action: \.weightInput)) { store in
                WeightInputView(store: store)
            }
        }
    }

}

#Preview {
    HeightInputView(store: Store(initialState: HeightInputFeature.State(onboardingUserModel: .init())) {
        HeightInputFeature()
    })
}
