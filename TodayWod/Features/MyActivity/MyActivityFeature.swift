//
//  MyActivityFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/8/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MyActivityFeature {
    
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
        let recentDayWorkouts: [DayWorkoutModel] = [] // TODO: 최근 활동 CoreData 호출로 변경.
        var path = StackState<Path.State>()
    }

    enum Action {
        case onAppear
        case path(StackActionOf<Path>)
        case didTapMyPage
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                if let onbarodingUserInfoModel = UserDefaultsManager().loadOnboardingUserInfo() {
                    state.onboardingUserInfoModel = onbarodingUserInfoModel
                }
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
            }
        }
        .forEach(\.path, action: \.path)
    }

}

import SwiftUI

struct MyActivityView: View {

    @Perception.Bindable var store: StoreOf<MyActivityFeature>

    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                ScrollView {
                    VStack {
                        HStack(spacing: 4) {
                            if store.state.onboardingUserInfoModel?.gender == .man {
                                Images.genderMan.swiftUIImage
                                    .resizable()
                                    .frame(width: 48.0, height: 48.0)
                            } else {
                                Images.genderWoman.swiftUIImage
                                    .resizable()
                                    .frame(width: 48.0, height: 48.0)
                            }
                            VStack(alignment: .leading, spacing: 4.0) {
                                Text(store.onboardingUserInfoModel?.nickName ?? "No name")
                                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 20.0))
                                    .foregroundStyle(.grey100)
                                Text(store.onboardingUserInfoModel?.level?.title ?? "No Level")
                                    .font(Fonts.Pretendard.regular.swiftUIFont(size: 12.0))
                                    .foregroundStyle(.grey70)
                            }

                            Spacer()

                            Images.icChevronForward16.swiftUIImage
                        }
                        .padding(.vertical, 12.0)
                        .padding(.horizontal, 20.0)
                        .contentShape(Rectangle())
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
                            ForEach(store.recentDayWorkouts) { dayWorkout in
                                HStack(spacing: 8.0) {
                                    Images.genderMan.swiftUIImage
                                        .resizable()
                                        .frame(width: 48.0, height: 48.0)
                                    VStack(alignment: .leading, spacing: 6.0) {
                                        HStack {
                                            Text(dayWorkout.title)
                                                .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                                                .foregroundStyle(.grey100)
                                            Spacer()
                                            Text(dayWorkout.duration.timerFormatter)
                                                .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                                                .foregroundStyle(.grey100)
                                        }
                                        Text(dayWorkout.displayDate)
                                            .font(Fonts.Pretendard.regular.swiftUIFont(size: 13.0))
                                            .foregroundStyle(.grey70)
                                    }
                                    Spacer()
                                }
                                .padding(20.0)
                                .background(.grey10)
                                .clipShape(.rect(cornerRadius: 12.0))
                                .padding(.horizontal, 20.0)
                            }
                        }
                    }
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
        }

    }

}

#Preview {
    MyActivityView(store: Store(initialState: MyActivityFeature.State()){
        MyActivityFeature()
    })
}
