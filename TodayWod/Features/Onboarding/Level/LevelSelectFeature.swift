//
//  LevelSelectFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/16/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct LevelSelectFeature {

    @ObservableState
    struct State: Equatable {
        var level: LevelType? = nil
        var onboardingUserModel: OnboardingUserInfoModel

        var isValidLevel: Bool = false
        var entryType: EntryType = .onBoarding
        var buttonTitle: String {
            self.entryType == .modify ? "확인" : "다음"
        }

        @Shared(.appStorage(SharedConstants.isLaunchProgram)) var isLaunchProgram = false
        @Shared(.appStorage(SharedConstants.onCelebrate)) var onCelebrate = false
        
        @Presents var alert: AlertState<Action.Alert>?
    }

    enum Action {
        case onAppear
        case didTapBackButton
        case didTapNextButton
        case saveUserInfo
        case onConfirmAlert
        case setLevel(LevelType)
        case finishInputLevel(MethodSelectFeature.State)
        case saveData(LevelType)
        case alert(PresentationAction<Alert>)
        
        @CasePathable
        enum Alert: Equatable {
            case resetLevel
        }
    }

    @Dependency(\.dismiss) var dismiss
    @Dependency(\.wodClient) var wodClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.level = state.onboardingUserModel.level
                state.isValidLevel = state.level != nil
                return .none
            case .didTapBackButton:
                if let level = state.level {
                    return .concatenate(
                        .send(.saveData(level)),
                        .run { _ in await dismiss() }
                    )
                } else {
                    return .run { _ in await dismiss() }
                }
            case .didTapNextButton:
                return state.entryType == .onBoarding ? .send(.saveUserInfo) : .send(.onConfirmAlert)
            case .saveUserInfo:
                state.onboardingUserModel.level = state.level

                return .send(.finishInputLevel(MethodSelectFeature.State(onboardingUserModel: state.onboardingUserModel)))
            case .onConfirmAlert:
                state.alert = AlertState {
                    TextState("운동 루틴 초기화")
                } actions: {
                    ButtonState(role: .destructive) {
                        TextState("취소")
                    }
                    ButtonState(role: .cancel, action: .send(.resetLevel)) {
                        TextState("확인")
                    }
                } message: {
                    TextState("새로운 수준과 방식에 맞게\n운동 루틴이 초기화돼요")
                }
                return .none
            case .alert(.presented(.resetLevel)):
                let userDefaultsManager = UserDefaultsManager()
                guard var onboardingUserModel = userDefaultsManager.loadOnboardingUserInfo() else { return .none }
                onboardingUserModel.level = state.level
                userDefaultsManager.saveOnboardingUserInfo(data: onboardingUserModel)

                state.isLaunchProgram = false
                state.onCelebrate = false
                
                return .run { _ in
                    try await wodClient.removePrograms()
                    await dismiss()
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
            case .alert:
                return .none
            case .saveData:
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
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
                ZStack(alignment: .bottom) {
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

                            LazyVStack(spacing: 10.0) {
                                ForEach(LevelType.allCases, id: \.self) { type in
                                    WithPerceptionTracking {
                                        LevelCardView(type: type, isSelected: store.state.level == type)
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                store.send(.setLevel(type))
                                            }                                        
                                    }
                                }
                            }
                            .padding(.top, 40.0)
                        }
                        .padding(.bottom, 56.0 + 40.0) // Button size(56.0 + bottom padding size(20.0) + padding size(20.0
                    }

                    VStack {
                        BottomButton(title: store.state.buttonTitle) {
                            store.send(.didTapNextButton)
                        }
                        .disabled(!store.isValidLevel)
                        .padding(.bottom, 20.0)
                        .padding(.horizontal, 38.0)
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .onAppear {
                store.send(.onAppear)
            }
            .alert($store.scope(state: \.alert, action: \.alert))
        }
    }

}

extension LevelSelectView {
    
    enum Constants {
        static let title: String = "나만의 운동 프로그램을\n설정할게요!"
        static let subTitle: String = "운동 수준을 알려주세요."
    }
    
}

#Preview {
    LevelSelectView(store: Store(initialState: LevelSelectFeature.State(onboardingUserModel: .init())) {
        LevelSelectFeature()
    })
}
