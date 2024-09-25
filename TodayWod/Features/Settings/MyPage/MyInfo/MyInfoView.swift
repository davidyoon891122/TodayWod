//
//  MyInfoView.swift
//  TodayWod
//
//  Created by Davidyoon on 9/25/24.
//

import SwiftUI

struct MyInfoView: View {
    
    let userInfo: [UserInfoSubItemModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("내 정보")
                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                Spacer()
            }
            .padding(.top, 25.0)
            
            LazyVStack {
                ForEach(userInfo, id: \.title) { item in
                    MyPageRowItemView(model: item)
                }
            }
            .padding(.bottom, 30.0)
        }
        .padding(.horizontal, 20.0)
    }
}

#Preview {
    MyInfoView(userInfo: OnboardingUserInfoModel.preview.convertToSubArray())
}
