//
//  MyPageFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/24/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MyPageFeature {
    
    @ObservableState
    struct State: Equatable {
        let version: String = PlistReader().getMainInfo(key: AppEnvironmentConstants.shortVersion)

        var onboardingUserInfoModel: OnboardingUserInfoModel

        init(onboardingUserInfoModel: OnboardingUserInfoModel) {
            self.onboardingUserInfoModel = onboardingUserInfoModel
        }
        
        @Shared(.inMemory(SharedConstants.hideTabBar)) var hideTabBar: Bool = true
    }

    enum Action {
        case onAppear
        case didTapBackButton
        case didTapModifyProfileButton(OnboardingUserInfoModel?)
        case didTapInfoButton(UserInfoType)
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.userDefaultsClient) var userDefaultsClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                if let onboardingUserInfoModel = userDefaultsClient.loadOnboardingUserInfo() {
                    state.onboardingUserInfoModel = onboardingUserInfoModel
                }
                state.hideTabBar = true
                return .none
            case .didTapBackButton:
                state.hideTabBar = false
                return .run { _ in await dismiss() }
            case .didTapModifyProfileButton:
                return .none
            case .didTapInfoButton:
                return .none
            }
        }
    }

}

import SwiftUI

struct MyPageView: View {
    let store: StoreOf<MyPageFeature>

    var body: some View {
        WithPerceptionTracking { 
            VStack {
                CustomNavigationView {
                    store.send(.didTapBackButton)
                }
                ScrollView {
                    LazyVStack {
                        ProfileView(nickName: store.onboardingUserInfoModel.nickName ?? "", gender: store.onboardingUserInfoModel.gender ?? .man) {
                            store.send(.didTapModifyProfileButton(store.state.onboardingUserInfoModel))
                        }
                        CustomDivider(color: .grey20, size: 5, direction: .horizontal)
                        MyInfoView(store: store, userInfo: store.onboardingUserInfoModel.convertToSubArray())
                        CustomDivider(color: .grey20, size: 5, direction: .horizontal)
                        VersionInfoView(version: store.version)
                    }
                }
            }
            .onAppear {
                store.send(.onAppear)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        
    }

}

#Preview {
    MyPageView(store: Store(initialState: MyPageFeature.State(onboardingUserInfoModel: .preview)) {
        MyPageFeature()
    })
}
