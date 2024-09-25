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
    }

    enum Action {
        
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {

            }
        }
    }

}

import SwiftUI

struct MyPageView: View {
    let store: StoreOf<MyPageFeature>

    var body: some View {
        ScrollView {
            LazyVStack {
                ProfileView(nickName: store.userInfoModel.nickName ?? "")
                CustomDivider(color: .grey20, size: 5, direction: .horizontal)
                MyInfoView(userInfo: store.userInfoModel.convertToSubArray())
                CustomDivider(color: .grey20, size: 5, direction: .horizontal)
                VersionInfoView()
            }
        }
    }

}

#Preview {
    MyPageView(store: Store(initialState: MyPageFeature.State()) {
        MyPageFeature()
    })
}
