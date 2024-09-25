//
//  VersionInfoView.swift
//  TodayWod
//
//  Created by Davidyoon on 9/25/24.
//

import SwiftUI

struct VersionInfoView: View {
    
    var body: some View {
        VStack {
            HStack {
                Text("버전 정보")
                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                Spacer()
            }
            .padding(.top, 25.0)
            
            MyPageRowItemView(title: "24.0.1", value: "최신버전")
        }
        .padding(.horizontal, 20.0)
    }
    
}

#Preview {
    VersionInfoView()
}
