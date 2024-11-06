//
//  GenderSelectFeature.swift
//  TodayWod
//
//  Created by Davidyoon on 9/12/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct GenderSelectFeature {

    @Reducer(state: .equatable)
    enum Path {
        case nickName(NicknameFeature)
        case height(HeightInputFeature)
        case weight(WeightInputFeature)
        case level(LevelSelectFeature)
        case method(MethodSelectFeature)
    }

    @ObservableState
    struct State: Equatable {
        let title: String = "나만의 운동 프로그램을\n설정할게요!"
        let subTitle: String = "성별을 선택해주세요."
        var gender: GenderType? = nil
        var path = StackState<Path.State>()
        var onboardingUserModel: OnboardingUserInfoModel = .init()
    }
    
    enum Action {
        case setGender(GenderType)
        case path(StackActionOf<Path>)
        case toNickname
        case finishOnboarding
    }
    
    @Dependency(\.continuousClock) var clock
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .setGender(genderType):
                state.gender = genderType
                state.onboardingUserModel.gender = genderType
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.prepare()
                generator.impactOccurred()

                return .run(operation: { send in
                    try await clock.sleep(for: .seconds(0.3))
                    await send(.toNickname)
                })
            case let .path(action):
                switch action {
                case .element(id: _, action: .nickName(.finishInputNickname(let heightState))):
                    var heightState = heightState
                    heightState.onboardingUserModel.height = state.onboardingUserModel.height
                    state.path.append(.height(heightState))
                    return .none
                case .element(id: _, action: .height(.finishInputHeight(let weightState))):
                    var weightState = weightState
                    weightState.onboardingUserModel.weight = state.onboardingUserModel.weight
                    state.path.append(.weight(weightState))
                    return .none
                case .element(id: _, action: .weight(.finishInputWeight(let levelState))):
                    var levelState = levelState
                    levelState.onboardingUserModel.level = state.onboardingUserModel.level
                    state.path.append(.level(levelState))
                    return .none
                case .element(id: _, action: .level(.finishInputLevel(let methodState))):
                    state.path.append(.method(methodState))
                    return .none
                case .element(id: _, action: .method(.finishOnboarding)):
                    return .send(.finishOnboarding)
                case .element(id: _, action: .nickName(.saveDataBeforeDismiss(let nickName))):
                    state.onboardingUserModel.nickName = nickName
                    return .none
                case .element(id: _, action: .height(.saveDataBeforeDismiss(let height))):
                    if let intHeight = Int(height) {
                        state.onboardingUserModel.height = intHeight
                    } else {
                        state.onboardingUserModel.height = nil
                    }
                    return .none
                case .element(id: _, action: .weight(.saveDataBeforeDismiss(let weight))):
                    if let intWeight = Int(weight) {
                        state.onboardingUserModel.weight = intWeight
                    } else {
                        state.onboardingUserModel.weight = nil
                    }
                    return .none
                case .element(id: _, action: .level(.saveDataBeforeDismiss(let level))):
                    state.onboardingUserModel.level = level
                    return .none
                default:
                    return .none
                }
            case .toNickname:
                state.path.append(.nickName(NicknameFeature.State(onboardingUserModel: state.onboardingUserModel)))
                return .none

            case .finishOnboarding:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
    
}

import SwiftUI

struct GenderSelectView: View {
    
    @Perception.Bindable var store: StoreOf<GenderSelectFeature>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                VStack {
                    ScrollView {
                        HStack {
                            Text(store.title)
                                .font(Fonts.Pretendard.bold.swiftUIFont(size: 24.0))
                                .foregroundStyle(.grey100)
                                .lineLimit(2)
                            Spacer()
                        }
                        .padding(.top, 58.0)
                        .padding(.horizontal, 20.0)
                        HStack {
                            Text(store.subTitle)
                                .font(Fonts.Pretendard.regular.swiftUIFont(size: 20.0))
                                .foregroundStyle(.grey80)
                                .lineLimit(1)
                            Spacer()
                        }
                        .padding(.top, 16.0)
                        .padding(.horizontal, 20.0)
                        
                        HStack {
                            Button(action: {
                                store.send(.setGender(.man))
                            }, label: {
                                Images.genderMan.swiftUIImage
                                    .resizable()
                                    .frame(width: 160, height: 160)
                                    .clipShape(.circle)
                                    .opacity(store.gender == .man ? 1.0 : 0.6)
                            })
                            
                            Button(action: {
                                store.send(.setGender(.woman))
                            }, label: {
                                Images.genderWoman.swiftUIImage
                                    .resizable()
                                    .frame(width: 160, height: 160)
                                    .clipShape(.circle)
                                    .opacity(store.gender == .woman ? 1.0 : 0.6)
                            })
                        }
                        .padding(.top, 80.0)
                        .padding(.horizontal)
                    }
                }
            } destination: { store in
                switch store.case {
                case let .nickName(store):
                    NicknameInputView(store: store)
                case let .height(store):
                    HeightInputView(store: store)
                case let .weight(store):
                    WeightInputView(store: store)
                case let .level(store):
                    LevelSelectView(store: store)
                case let .method(store):
                    MethodSelectView(store: store)
                }
            }
        }
    }
}

#Preview {
    GenderSelectView(store: Store(initialState: GenderSelectFeature.State()) {
        GenderSelectFeature()
    })
}
