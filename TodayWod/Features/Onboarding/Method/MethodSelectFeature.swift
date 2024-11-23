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
        var isButtonEnabled: Bool = false
        var methodType: ProgramMethodType? = nil
        var onboardingUserModel: OnboardingUserInfoModel
        var entryType: EntryType = .onBoarding
        var buttonTitle: String {
            self.entryType == .modify ? "확인" : "시작하기"
        }

        var dynamicHeight: CGFloat = .zero
        @Shared(.appStorage(SharedConstants.isLaunchProgram)) var isLaunchProgram = false
        @Shared(.appStorage(SharedConstants.onCelebrate)) var onCelebrate = false

        @Presents var methodDescription: MethodDescriptionFeature.State?
        @Presents var alert: AlertState<Action.Alert>?
    }

    enum Action {
        case onAppear
        case didTapBackButton
        case didTapStartButton
        case saveUserInfo
        case onConfirmAlert
        case setMethod(ProgramMethodType)
        case methodDescriptionTap(PresentationAction<MethodDescriptionFeature.Action>)
        case didTapBodyDescriptionButton
        case didTapMachineDescriptionButton
        case finishOnboarding
        case setDynamicHeight(CGFloat)
        case saveData(ProgramMethodType)
        case alert(PresentationAction<Alert>)
        
        @CasePathable
        enum Alert: Equatable {
            case resetMethod
        }
    }

    @Dependency(\.dismiss) var dismiss
    @Dependency(\.wodClient) var wodClient
    @Dependency(\.userDefaultsClient) var userDefaultsClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.methodType = state.onboardingUserModel.method
                switch state.entryType {

                case .onBoarding:
                    state.isButtonEnabled = state.methodType != nil
                case .modify:
                    if state.methodType != nil, let savedData = userDefaultsClient.loadOnboardingUserInfo() {
                        state.isButtonEnabled = savedData.method != state.methodType
                    }
                }

                return .none
            case .didTapBackButton:
                if let method = state.methodType {
                    return .concatenate(
                        .send(.saveData(method)),
                        .run { _ in await dismiss() }
                    )
                } else {
                    return .run { _ in await dismiss() }
                }
            case .didTapStartButton:
                return state.entryType == .onBoarding ? .send(.saveUserInfo) : .send(.onConfirmAlert)
            case .saveUserInfo:
                userDefaultsClient.saveOnboardingUserInfo(state.onboardingUserModel)
                return .send(.finishOnboarding)
            case .onConfirmAlert:
                state.alert = AlertState {
                    TextState("운동 루틴 초기화")
                } actions: {
                    ButtonState(role: .destructive) {
                        TextState("취소")
                    }
                    ButtonState(role: .cancel, action: .send(.resetMethod)) {
                        TextState("확인")
                    }
                } message: {
                    TextState("새로운 수준과 방식에 맞게\n운동 루틴이 초기화돼요")
                }
                return .none
            case .alert(.presented(.resetMethod)):
                guard var onboadingUserModel = userDefaultsClient.loadOnboardingUserInfo() else { return .none }
                onboadingUserModel.method = state.methodType
                userDefaultsClient.saveOnboardingUserInfo(onboadingUserModel)

                state.isLaunchProgram = false
                state.onCelebrate = false
                
                return .run { _ in
                    try wodClient.removePrograms()
                    await dismiss()
                }
            case let .setMethod(methodType):
                state.methodType = methodType
                state.onboardingUserModel.method = methodType
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.prepare()
                generator.impactOccurred()

                switch state.entryType {

                case .onBoarding:
                    state.isButtonEnabled = state.methodType != nil
                case .modify:
                    if state.methodType != nil, let savedData = userDefaultsClient.loadOnboardingUserInfo() {
                        state.isButtonEnabled = savedData.method != state.methodType
                    }
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
            case .alert:
                return .none
            case .saveData:
                return .none
            }
        }
        .ifLet(\.$methodDescription, action: \.methodDescriptionTap) {
            MethodDescriptionFeature()
        }
        .ifLet(\.$alert, action: \.alert)
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
                    BottomButton(title: store.state.buttonTitle) {
                        store.send(.didTapStartButton)
                    }
                    .disabled(!store.isButtonEnabled)
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
            .onAppear {
                store.send(.onAppear)
            }
            .alert($store.scope(state: \.alert, action: \.alert))
        }
    }
}

private extension MethodSelectView {
    
    enum Constants {
        static let title: String = "나만의 운동 프로그램을\n설정할게요!"
        static let subTitle: String = "운동 방식을 선택해주세요."
    }
    
}

#Preview {
    MethodSelectView(store: Store(initialState: MethodSelectFeature.State(onboardingUserModel: .init())) {
        MethodSelectFeature()
    })
}
