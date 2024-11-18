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
    }

    @ObservableState
    struct State: Equatable {
        var onboardingUserInfoModel: OnboardingUserInfoModel?
        var recentDayWorkouts: [DayWorkoutModel] = []
        var completedDates: Set<Date> = []
        var path = StackState<Path.State>()
        
        @Shared(.inMemory(SharedConstants.hideTabBar)) var hideTabBar: Bool = true
        @Presents var completedState: WorkoutCompletedFeature.State?
    }
    
    @Dependency(\.wodClient) var wodClient
    @Dependency(\.userDefaultsClient) var userDefaultsClient

    enum Action: BindableAction {
        case onAppear
        case getRecentDayWorkouts
        case recentDayWorkoutsResponse([DayWorkoutModel])
        case getCompletedDates
        case completedDatesResponse([CompletedDateModel])
        case path(StackActionOf<Path>)
        case didTapMyPage
        case didTapMyActivity(DayWorkoutModel)
        case completedAction(PresentationAction<WorkoutCompletedFeature.Action>)
        case binding(BindingAction<State>)
        case loadUserDefault
        case loadUserDefaultResult(Result<OnboardingUserInfoModel, Error>)
    }

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                FLog().enter()
                
                state.hideTabBar = false
                
                return .concatenate(.send(.loadUserDefault),
                                    .send(.getRecentDayWorkouts),
                                    .send(.getCompletedDates))
            case .getRecentDayWorkouts:
                return .run { send in
                    do {
                        let recentDayWorkouts = try await wodClient.getRecentDayWorkouts()
                        await send(.recentDayWorkoutsResponse(recentDayWorkouts))
                    } catch {
                        // TODO: - Load 에러 처리
                        print("error: \(error.localizedDescription)")
                    }
                }
            case let .recentDayWorkoutsResponse(dayWorkouts):
                state.recentDayWorkouts = dayWorkouts
                return .none
            case .getCompletedDates:
                return .run { send in
                    do {
                        let dates = try await wodClient.getCompletedDates()
                        await send(.completedDatesResponse(dates))
                    } catch {
                        // TODO: - Load 에러 처리
                        print("error: \(error.localizedDescription)")
                    }
                }
            case let .completedDatesResponse(dates):
                state.completedDates = Set(dates.map { $0.date })
                return .none
            case let .path(action):
                switch action {
                case .element(id: _, action: .myPage(let .didTapModifyProfileButton(onboardingUserInfoModel))):
                    if let onboardingUserInfoModel = onboardingUserInfoModel {
                        state.path.append(.modifyProfile(ModifyProfileFeature.State(onboardingUserInfoModel: onboardingUserInfoModel)))
                    }
                    return .none
                case .element(id: _, action: .myPage(let .didTapInfoButton(userInfoType))):
                    switch userInfoType {
                    case .gender, .height, .version:
                        return .none
                    case .weight:
                        state.path.append(.modifyWeight(ModifyWeightFeature.State()))
                        return .none
                    case .level:
                        if let onboardingUserInfoModel = userDefaultsClient.loadOnboardingUserInfo() {
                            state.path.append(.modifyLevel(LevelSelectFeature.State(onboardingUserModel: onboardingUserInfoModel, entryType: .modify)))
                        }
                        return .none
                    case .method:
                        if let onboardingUserInfoModel = userDefaultsClient.loadOnboardingUserInfo() {
                            state.path.append(.modifyMethod(MethodSelectFeature.State(onboardingUserModel: onboardingUserInfoModel, entryType: .modify)))
                        }
                        return .none
                    }
                default:
                    return .none
                }
            case .didTapMyPage:
                if let onboardingUserInfoModel = state.onboardingUserInfoModel {
                    state.path.append(.myPage(MyPageFeature.State(onboardingUserInfoModel: onboardingUserInfoModel)))
                }
                return .none
            case let .didTapMyActivity(workout):
                FLog().tap("myActivity")
                state.completedState = WorkoutCompletedFeature.State(item: workout)
                return .none
            case .completedAction(.presented(.didTapCloseButton)):
                return .none
            case .loadUserDefault:
                return .run { send in
                    if let result = userDefaultsClient.loadOnboardingUserInfo() {
                        await send(.loadUserDefaultResult(.success(result)))
                    } else {
                        await send(.loadUserDefaultResult(.failure(UserDefaultsError.emptyData)))
                    }
                }
            case .loadUserDefaultResult(.success(let userInfo)):
                state.onboardingUserInfoModel = userInfo
                return .none
            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
        .ifLet(\.$completedState, action: \.completedAction) {
            WorkoutCompletedFeature()
        }
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

                        CalendarView(month: Date(), markedDates: $store.completedDates)
                            .padding(.horizontal, 19.0)
                            .padding(.top, 4.0)
                        
                        BannerAdView()
                            .padding(20.0)

                        HStack {
                            Text("최근 활동")
                                .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                                .padding(.horizontal, 20.0)
                                .padding(.vertical, 4.0)
                                .foregroundStyle(.grey100)
                            Spacer()
                        }
                        .padding(.top, 20.0)
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
                }
            }
            .sheet(item: $store.scope(state: \.completedState, action: \.completedAction)) { store in
                WorkoutCompletedView(store: store)
            }
        }

    }

}

#Preview {
    SettingView(store: Store(initialState: SettingFeature.State()){
        SettingFeature()
    })
}
