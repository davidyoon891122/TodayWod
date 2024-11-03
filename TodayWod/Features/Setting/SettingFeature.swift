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
        var onboardingUserInfoModel: OnboardingUserInfoModel? = UserDefaultsManager().loadOnboardingUserInfo()
        var recentDayWorkouts: [DayWorkoutModel] = []
        var completedDates: Set<Date> = []
        var path = StackState<Path.State>()
        
        @Presents var completedState: WorkoutCompletedFeature.State?
        @Presents var alert: AlertState<Action.Alert>?
    }
    
    @Dependency(\.wodClient) var wodClient

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
        case alert(PresentationAction<Alert>)
        
        @CasePathable
        enum Alert: Equatable {
            case resetLevel
            case resetMethod
        }
    }

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                if let onbarodingUserInfoModel = UserDefaultsManager().loadOnboardingUserInfo() {
                    state.onboardingUserInfoModel = onbarodingUserInfoModel
                }
                
                return .merge(.send(.getRecentDayWorkouts),
                              .send(.getCompletedDates))
            case .getRecentDayWorkouts:
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
            case .getCompletedDates:
                return .run { send in
                    do {
                        let dates = try wodClient.getCompletedDates()
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
                    case .method:
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
                    }
                default:
                    return .none
                }
            case .didTapMyPage:
                state.path.append(.myPage(MyPageFeature.State()))
                return .none
            case let .didTapMyActivity(workout):
                state.completedState = WorkoutCompletedFeature.State(item: workout)
                return .none
            case .alert(.presented(.resetLevel)):
                if let onboardingUserInfoModel = state.onboardingUserInfoModel {
                    state.path.append(.modifyLevel(LevelSelectFeature.State(onboardingUserModel: onboardingUserInfoModel, entryType: .modify)))
                }
                return .none
            case .alert(.presented(.resetMethod)):
                if let onboardingUserInfoModel = state.onboardingUserInfoModel {
                    state.path.append(.modifyMethod(MethodSelectFeature.State(onboardingUserModel: onboardingUserInfoModel, entryType: .modify)))
                }
                return .none
            case .completedAction(.presented(.didTapCloseButton)):
                return .none
            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
        .ifLet(\.$completedState, action: \.completedAction) {
            WorkoutCompletedFeature()
        }
        .ifLet(\.$alert, action: \.alert)
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
                }
            }
            .sheet(item: $store.scope(state: \.completedState, action: \.completedAction)) { store in
                WorkoutCompletedView(store: store)
            }
            .alert($store.scope(state: \.alert, action: \.alert))
        }

    }

}

#Preview {
    SettingView(store: Store(initialState: SettingFeature.State()){
        SettingFeature()
    })
}
