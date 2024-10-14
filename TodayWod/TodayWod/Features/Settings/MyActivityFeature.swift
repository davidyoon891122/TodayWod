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

    @ObservableState
    struct State: Equatable {
        let onboardingUserInfoModel: OnboardingUserInfoModel? = UserDefaultsManager().loadOnboardingUserInfo()
        let recentActivityModel: RecentActivityModel = .fake
        var path = StackState<MyPageFeature.State>()
    }

    enum Action {
        case path(StackAction<MyPageFeature.State, MyPageFeature.Action>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            MyPageFeature()
        }
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
                        NavigationLink(state: MyPageFeature.State()) {
                            HStack(spacing: 4) {
                                Images.genderMan.swiftUIImage
                                    .resizable()
                                    .frame(width: 48.0, height: 48.0)
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
                            ForEach(store.recentActivityModel.workOutDayModels) { model in
                                HStack(spacing: 8.0) {
                                    Images.genderMan.swiftUIImage
                                        .resizable()
                                        .frame(width: 48.0, height: 48.0)
                                    VStack(alignment: .leading, spacing: 6.0) {
                                        HStack {
                                            Text("\(model.title)")
                                                .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                                                .foregroundStyle(.grey100)
                                            Spacer()
                                            Text("01:42:10")
                                                .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                                                .foregroundStyle(.grey100)
                                        }
                                        Text("2024년 9월 31일 화요일")
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
            } destination: { store in
                MyPageView(store: store)
            }
        }
    }

}

#Preview {
    MyActivityView(store: Store(initialState: MyActivityFeature.State()){
        MyActivityFeature()
    })
}
