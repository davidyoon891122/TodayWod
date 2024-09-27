//
//  VersionInfoView.swift
//  TodayWod
//
//  Created by Davidyoon on 9/25/24.
//

import SwiftUI

struct VersionInfoView: View {
    
    let version: String
    
    var body: some View {
        VStack {
            HStack {
                Text("버전 정보")
                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                Spacer()
            }
            .padding(.top, 25.0)
            
            MyPageRowItemView(model: .init(title: "\(version)", value: "최신버전", type: .version)) {
                
            }
        }
        .padding(.horizontal, 20.0)
        .padding(.bottom, 30.0)
    }
    
}

#Preview {
    VersionInfoView(version: "0.0.1")
}
