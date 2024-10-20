//
//  SettingFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/8/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SettingFeature {
    
    @Reducer(state: .equatable)
    enum Path {
        case myPage(MyPageFeature)
        case modifyProfile(ModifyProfileFeature)
        case modifyWeight(ModifyWeightFeature)
        case modifyLevel(LevelSelectFeature)
        case modifyMethod(MethodSelectFeature)
        case completed(WorkOutCompletedFeature)
    }

    @ObservableState
    struct State: Equatable {
        var onboardingUserInfoModel: OnboardingUserInfoModel? = UserDefaultsManager().loadOnboardingUserInfo()
        var recentDayWorkouts: [DayWorkoutModel] = []
        var path = StackState<Path.State>()
    }
    
    @Dependency(\.wodClient) var wodClient

    enum Action {
        case onAppear
        case recentDayWorkoutsResponse([DayWorkoutModel])
        case path(StackActionOf<Path>)
        case didTapMyPage
        case didTapMyActivity(DayWorkoutModel)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                if let onbarodingUserInfoModel = UserDefaultsManager().loadOnboardingUserInfo() {
                    state.onboardingUserInfoModel = onbarodingUserInfoModel
                }
                
                return .run { send in
                    do {
                        let recentDayWorkouts = try wodClient.getRecentDayWorkouts()
                        await send(.recentDayWorkoutsResponse(recentDayWorkouts))
                    } catch {
                        // TODO: - Load 에러 처리
                        print("error: \(error.localizedDescription)")
                    }
                }
            case let .recentDayWorkoutsResponse(dayWorkouts):
                state.recentDayWorkouts = dayWorkouts
                return .none
            case let .path(action):
                switch action {
                case .element(id: _, action: .myPage(let .didTapModifyProfileButton(onboardingUserInfoModel))):
                    state.path.append(.modifyProfile(ModifyProfileFeature.State(onboardingUserInfoModel: onboardingUserInfoModel)))
                    return .none
                case .element(id: _, action: .myPage(let .didTapInfoButton(userInfoType))):
                    switch userInfoType {
                    case .gender, .height, .version:
                        return .none
                    case .weight:
                        state.path.append(.modifyWeight(ModifyWeightFeature.State()))
                        return .none
                    case .level:
                        if let onboardingUserInfoModel = state.onboardingUserInfoModel {
                            state.path.append(.modifyLevel(LevelSelectFeature.State(onboardingUserModel: onboardingUserInfoModel, entryType: .modify)))
                        }
                        return .none
                    case .method:
                        if let onboardingUserInfoModel = state.onboardingUserInfoModel {
                            state.path.append(.modifyMethod(MethodSelectFeature.State(onboardingUserModel: onboardingUserInfoModel, entryType: .modify)))
                        }
                        return .none
                    }
                default:
                    return .none
                }
            case .didTapMyPage:
                state.path.append(.myPage(MyPageFeature.State()))
                return .none
            case let .didTapMyActivity(workout):
                state.path.append(.completed(WorkOutCompletedFeature.State(item: workout)
))
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }

}

import SwiftUI

struct SettingView: View {

    @Perception.Bindable var store: StoreOf<SettingFeature>

    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                ScrollView {
                    VStack {
                        MyPageInfoView(model: store.state.onboardingUserInfoModel)
                            .onTapGesture {
                                store.send(.didTapMyPage)
                            }

                        CalendarView(month: Date(), markedDates: [Date()])
                            .padding(.horizontal, 19)
                            .padding(.vertical, 24.0)

                        HStack {
                            Text("최근 활동")
                                .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                                .padding(.horizontal, 20.0)
                                .padding(.vertical, 4.0)
                                .foregroundStyle(.grey100)
                            Spacer()
                        }
                        LazyVStack {
                            if store.recentDayWorkouts.isEmpty {
                                MyActivityEmptyView()
                            } else {
                                ForEach(store.recentDayWorkouts) { dayWorkout in
                                    MyActivityView(model: dayWorkout)
                                        .onTapGesture {
                                            store.send(.didTapMyActivity(dayWorkout))
                                        }
                                }
                            }
                        }
                    }
                    .padding(.bottom, 40)
                }
                .onAppear {
                    store.send(.onAppear)
                }
            } destination: { store in
                switch store.case {
                case let .myPage(store):
                    MyPageView(store: store)
                case let .modifyProfile(store):
                    ModifyProfileView(store: store)
                case let .modifyWeight(store):
                    ModifyWeightView(store: store)
                case let .modifyLevel(store):
                    LevelSelectView(store: store)
                case let .modifyMethod(store):
                    MethodSelectView(store: store)
                case let .completed(store):
                    WorkOutCompletedView(store: store)
                }
            }
        }

    }

}

#Preview {
    SettingView(store: Store(initialState: SettingFeature.State()){
        SettingFeature()
    })
}
