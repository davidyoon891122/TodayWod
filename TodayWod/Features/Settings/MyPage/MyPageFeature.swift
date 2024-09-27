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
        let userInfoModel = UserDefaultsManager().loadOnboardingUserInfo() ?? .preview
        let version: String = AppEnvironment.shortVersion
    }

    enum Action {
        case didTapBackButton
        case didTapModifyProfileButton(OnboardingUserInfoModel)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapBackButton:
                return .run { _ in await dismiss() }
            case .didTapModifyProfileButton:
                // TODO: - 프로필 수정 피처 추가
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
                        ProfileView(nickName: store.userInfoModel.nickName ?? "") {
                            store.send(.didTapModifyProfileButton(store.state.userInfoModel))
                        }
                        CustomDivider(color: .grey20, size: 5, direction: .horizontal)
                        MyInfoView(userInfo: store.userInfoModel.convertToSubArray())
                        CustomDivider(color: .grey20, size: 5, direction: .horizontal)
                        VersionInfoView(version: store.version)
                    }
                }
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
