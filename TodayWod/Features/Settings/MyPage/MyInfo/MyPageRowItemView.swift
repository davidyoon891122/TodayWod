//
//  MyInfoRowItemView.swift
//  TodayWod
//
//  Created by Davidyoon on 9/25/24.
//

import SwiftUI

struct MyPageRowItemView: View {
    
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(Fonts.Pretendard.regular.swiftUIFont(size: 16.0))
                .foregroundStyle(.grey100)
            Spacer()
            
            Button(action: {
                
            }, label: {
                HStack {
                    Text(value)
                        .font(Fonts.Pretendard.regular.swiftUIFont(size: 16.0))
                    Images.icChevronForward16.swiftUIImage
                }
            })
            .tint(.grey80)
        }
        .padding(.vertical, 12.0)
    }
}

#Preview {
    MyPageRowItemView(title: "성별", value: "남성")
}
