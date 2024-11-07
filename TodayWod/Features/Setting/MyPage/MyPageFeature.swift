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
        var userInfoModel = UserDefaultsManager().loadOnboardingUserInfo() ?? .preview
        let version: String = AppEnvironment.shortVersion
        
        @Shared(.inMemory("HideTabBar")) var hideTabBar: Bool = true
    }

    enum Action {
        case onAppear
        case didTapBackButton
        case didTapModifyProfileButton(OnboardingUserInfoModel)
        case didTapInfoButton(UserInfoType)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.hideTabBar = true
                guard let onboardingUserInfoModel = UserDefaultsManager().loadOnboardingUserInfo() else { return .none }
                state.userInfoModel = onboardingUserInfoModel
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
                        ProfileView(nickName: store.userInfoModel.nickName ?? "", gender: store.userInfoModel.gender ?? .man) {
                            store.send(.didTapModifyProfileButton(store.state.userInfoModel))
                        }
                        CustomDivider(color: .grey20, size: 5, direction: .horizontal)
                        MyInfoView(store: store, userInfo: store.userInfoModel.convertToSubArray())
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
    MyPageView(store: Store(initialState: MyPageFeature.State()) {
        MyPageFeature()
    })
}
