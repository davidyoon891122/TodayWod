//
//  LevelSelectFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/16/24.
//

import Foundation
import ComposableArchitecture

enum EntryType {
    case onBoarding
    case modify
}

@Reducer
struct LevelSelectFeature {

    @ObservableState
    struct State: Equatable {
        let title: String = "나만의 운동 프로그램을\n설정할게요!"
        let subTitle: String = "운동 수준을 알려주세요."
        var level: LevelType? = nil
        let buttonTitle: String = "다음"
        var onboardingUserModel: OnboardingUserInfoModel

        var isValidLevel: Bool = false
        var entryType: EntryType = .onBoarding
    }

    enum Action {
        case didTapBackButton
        case didTapNextButton
        case setLevel(LevelType)
        case finishInputLevel(MethodSelectFeature.State)
    }

    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapBackButton:
                return .run { _ in await dismiss() }
            case .didTapNextButton:
                switch state.entryType {
                case .onBoarding:
                    state.onboardingUserModel.level = state.level

                    return .send(.finishInputLevel(MethodSelectFeature.State(onboardingUserModel: state.onboardingUserModel)))
                case .modify:
                    let userDefaultsManager = UserDefaultsManager()
                    guard var onboardingUserModel = userDefaultsManager.loadOnboardingUserInfo() else { return .none }
                    onboardingUserModel.level = state.level
                    userDefaultsManager.saveOnboardingUserInfo(data: onboardingUserModel)

                    return .run { _ in await dismiss() }
                }

            case let .setLevel(level):
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.prepare()
                generator.impactOccurred()
                state.level = level
                if state.level != nil {
                    state.isValidLevel = true
                }
                return .none
            case .finishInputLevel:
                return .none
            }
        }
    }

}

import SwiftUI

struct LevelSelectView: View {

    @Perception.Bindable var store: StoreOf<LevelSelectFeature>

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

                    LazyVStack(spacing: 10.0) {
                        ForEach(LevelType.allCases, id: \.self) { type in
                            LevelCardView(type: type, store: store)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    store.send(.setLevel(type))
                                }
                        }
                    }
                    .padding(.top, 40.0)

                    Spacer()

                    Button(action: {
                        store.send(.didTapNextButton)
                    }, label: {
                        Text(store.buttonTitle)
                            .nextButtonStyle()
                    })
                    .disabled(!store.isValidLevel)
                    .padding(.bottom, 20.0)
                    .padding(.horizontal, 38.0)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }

}

#Preview {
    LevelSelectView(store: Store(initialState: LevelSelectFeature.State(onboardingUserModel: .init())) {
        LevelSelectFeature()
    })
}

struct LevelCardView: View {

    let type: LevelType

    @Perception.Bindable var store: StoreOf<LevelSelectFeature>

    var body: some View {
        WithPerceptionTracking {
            VStack {
                HStack {
                    Text("\(type.title)")
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 18.0))
                        .foregroundStyle(store.state.level == type ? .blue60 : .grey100)
                    Spacer()
                }
                .padding(.horizontal, 16.0)
                .padding(.top, 16.0)
                HStack {
                    Text("\(type.description)")
                        .font(Fonts.Pretendard.regular.swiftUIFont(size: 13.0))
                        .foregroundStyle(.grey80)
                    Spacer()
                }
                .padding(.horizontal, 16.0)
                .padding(.top, 4.0)
                .padding(.bottom, 16.0)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 12.0)
                    .stroke(store.state.level == type ? .blue60 : .grey40)
            }
            .padding(.horizontal, 20.0)
        }
    }

}
