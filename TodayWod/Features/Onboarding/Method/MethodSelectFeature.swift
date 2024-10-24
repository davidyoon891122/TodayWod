//
//  MethodSelectFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/16/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MethodSelectFeature {

    @ObservableState
    struct State: Equatable {
        var isValidMethod: Bool = false
        var methodType: ProgramMethodType? = nil
        var onboardingUserModel: OnboardingUserInfoModel
        var entryType: EntryType = .onBoarding

        var dynamicHeight: CGFloat = .zero
        @Shared(.appStorage("IsLaunchProgram")) var isLaunchProgram = false

        @Presents var methodDescription: MethodDescriptionFeature.State?
    }

    enum Action {
        case didTapBackButton
        case didTapStartButton
        case saveUserInfo
        case setMethod(ProgramMethodType)
        case methodDescriptionTap(PresentationAction<MethodDescriptionFeature.Action>)
        case didTapBodyDescriptionButton
        case didTapMachineDescriptionButton
        case finishOnboarding
        case setDynamicHeight(CGFloat)
    }

    @Dependency(\.dismiss) var dismiss
    @Dependency(\.wodClient) var wodClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapBackButton:
                return .run { _ in await dismiss() }
            case .didTapStartButton:
                return .send(.saveUserInfo)
            case .saveUserInfo:
                let userDefaultsManager = UserDefaultsManager()
                
                switch state.entryType {
                case .onBoarding:
                    userDefaultsManager.saveOnboardingUserInfo(data: state.onboardingUserModel)

                    return .send(.finishOnboarding)
                case .modify:
                    guard var onboadingUserModel = userDefaultsManager.loadOnboardingUserInfo() else { return .none }
                    onboadingUserModel.method = state.methodType
                    userDefaultsManager.saveOnboardingUserInfo(data: onboadingUserModel)

                    state.isLaunchProgram = false
                    return .run { _ in
                        try await wodClient.removePrograms()
                        await dismiss()
                    }
                }
            case let .setMethod(methodType):
                state.methodType = methodType
                state.onboardingUserModel.method = methodType
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.prepare()
                generator.impactOccurred()

                if let _ = state.methodType {
                    state.isValidMethod = true
                }

                return .none
            case .methodDescriptionTap:
                return .none
            case .didTapBodyDescriptionButton:
                state.methodDescription = MethodDescriptionFeature.State(methodType: .body)
                return .none
            case .didTapMachineDescriptionButton:
                state.methodDescription = MethodDescriptionFeature.State(methodType: .machine)
                return .none
            case .finishOnboarding:
                return .none
            case let .setDynamicHeight(height):
                state.dynamicHeight = height
                return .none
            }
        }
        .ifLet(\.$methodDescription, action: \.methodDescriptionTap) {
            MethodDescriptionFeature()
        }
    }

}

import SwiftUI

struct MethodSelectView: View {

    @Perception.Bindable var store: StoreOf<MethodSelectFeature>

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
                            .padding(.horizontal, 20.0)
                        
                            MethodMenuView(store: store)
                            
                        }
                        .padding(.bottom, 56.0 + 20.0 + 20.0)
                    }
                    BottomButton(title: Constants.buttonTitle) {
                        store.send(.didTapStartButton)
                    }
                    .disabled(!store.isValidMethod)
                    .padding(.bottom, 20.0)
                    .padding(.horizontal, 38.0)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .sheet(item: $store.scope(state: \.methodDescription, action: \.methodDescriptionTap)) { descriptionStore in
                WithPerceptionTracking {
                    MethodDescriptionView(store: descriptionStore)
                        .measureHeight { height in
                            store.send(.setDynamicHeight(height))
                        }
                        .presentationDetents([.height(store.state.dynamicHeight + 20.0)])

                }
            }
        }
    }
}

private extension MethodSelectView {
    
    enum Constants {
        static let title: String = "나만의 운동 프로그램을\n설정할게요!"
        static let subTitle: String = "운동 방식을 선택해주세요."
        static let buttonTitle: String = "시작하기"
    }
    
}

#Preview {
    MethodSelectView(store: Store(initialState: MethodSelectFeature.State(onboardingUserModel: .init())) {
        MethodSelectFeature()
    })
}
