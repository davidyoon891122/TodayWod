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
        var version: String = AppEnvironment.shortVersion
        var shouldUpdate: Bool = false
        var onboardingUserInfoModel: OnboardingUserInfoModel
        var toast: ToastModel?

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
        case versionRequestResult(Result<AppInfoEntity, Error>)
        case setToast(ToastModel?)
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.userDefaultsClient) var userDefaultsClient
    @Dependency(\.apiClient) var apiClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                if let onboardingUserInfoModel = userDefaultsClient.loadOnboardingUserInfo() {
                    state.onboardingUserInfoModel = onboardingUserInfoModel
                }
                state.hideTabBar = true
                
                let bundleId = AppEnvironment.mainBundle.bundleIdentifier ?? ""
                let testBundleId = "com.ycompany.DreamTodo"
                
                return .run { send in
                    do {
                        let result = try await apiClient.requestAppVersion(.init(bundleId: testBundleId))
                        
                        await send(.versionRequestResult(.success(result)))
                    } catch {
                        await send(.versionRequestResult(.failure(error)))
                    }
                }
            case .didTapBackButton:
                state.hideTabBar = false
                return .run { _ in await dismiss() }
            case .didTapModifyProfileButton:
                return .none
            case .didTapInfoButton:
                return .none
            case .versionRequestResult(.success(let result)):
                if Int(result.version.replacingOccurrences(of: ".", with: "")) ?? 0 >= Int(AppEnvironment.shortVersion.replacingOccurrences(of: ".", with: "")) ?? 0 {
                    state.shouldUpdate = true
                }
                
                state.version = AppEnvironment.shortVersion
                return .none
                
            case .versionRequestResult(.failure(let error)):
                state.version = "버전 정보를 확인할 수 없어요."
                return .send(.setToast(.init(message: error.localizedDescription)))
            case .setToast(let toast):
                state.toast = toast
                return .none
            }
        }
    }

}

import SwiftUI

struct MyPageView: View {
    
    @Perception.Bindable var store: StoreOf<MyPageFeature>

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
            .toastView(toast: $store.toast.sending(\.setToast))
        }
        
    }

}

#Preview {
    MyPageView(store: Store(initialState: MyPageFeature.State(onboardingUserInfoModel: .preview)) {
        MyPageFeature()
    })
}
