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
        var shouldUpdate: Bool = false
        let version: String = PlistReader().getMainInfo(key: AppEnvironmentConstants.shortVersion)

        var onboardingUserInfoModel: OnboardingUserInfoModel
        var toast: ToastModel?
        var versionInfoState: VersionInfoFeature.State = VersionInfoFeature.State(version: PlistReader().getMainInfo(key: AppEnvironmentConstants.shortVersion))

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
        case versionRequestResult(Result<VersionInfoModel, Error>)
        case setToast(ToastModel?)
        case versionInfoAction(VersionInfoFeature.Action)
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.userDefaultsClient) var userDefaultsClient
    @Dependency(\.apiClient) var apiClient

    var body: some ReducerOf<Self> {
        Scope(state: \.versionInfoState, action: \.versionInfoAction) {
            VersionInfoFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                if let onboardingUserInfoModel = userDefaultsClient.loadOnboardingUserInfo() {
                    state.onboardingUserInfoModel = onboardingUserInfoModel
                }
                state.hideTabBar = true

                let bundleId = PlistReader().identifier // "com.ycompany.DreamTodo"
                
                return .run { send in
                    do {
                        let result = try await apiClient.requestAppVersion(.init(bundleId: bundleId))
                        
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
                if let currentVersion = VersionInfoModel(from: state.version) {
                    state.shouldUpdate = result > currentVersion
                }
                
                state.versionInfoState = VersionInfoFeature.State(version: state.version, shouldUpdate: state.shouldUpdate)
                return .none
            case .versionRequestResult(.failure(let error)):
                state.versionInfoState = VersionInfoFeature.State(version: state.version, shouldUpdate: state.shouldUpdate, versionInfo: "")
                return .send(.setToast(.init(message: error.localizedDescription)))
            case .setToast(let toast):
                state.toast = toast
                return .none
            case .versionInfoAction:
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
                        VersionInfoView(store: store.scope(state: \.versionInfoState, action: \.versionInfoAction))
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
