//
//  MyInfoView.swift
//  TodayWod
//
//  Created by Davidyoon on 9/25/24.
//

import SwiftUI
import ComposableArchitecture

struct MyInfoView: View {
    
    let store: StoreOf<MyPageFeature>
    
    let userInfo: [UserInfoSubItemModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(Constants.title)
                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                Spacer()
            }
            .padding(.top, 25.0)
            
            LazyVStack {
                ForEach(userInfo, id: \.title) { item in
                    MyPageRowItemView(model: item) {
                        store.send(.didTapInfoButton(item.type))
                    }
                }
            }
            .padding(.bottom, 30.0)
        }
        .padding(.horizontal, 20.0)
    }
}

private extension MyInfoView {
    
    enum Constants {
        static let title: String = "내 정보"
    }
    
}

#Preview {
    MyInfoView(store: Store(initialState: MyPageFeature.State()) {
        MyPageFeature()
    }, userInfo: OnboardingUserInfoModel.preview.convertToSubArray())
}
