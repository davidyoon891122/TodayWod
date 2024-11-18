//
//  MyInfoRowItemView.swift
//  TodayWod
//
//  Created by Davidyoon on 9/25/24.
//

import SwiftUI

struct MyPageRowItemView: View {
    
    let model: UserInfoSubItemModel
    
    var action: (() -> Void)? = nil

    var body: some View {
        HStack {
            Text(model.title)
                .font(Fonts.Pretendard.regular.swiftUIFont(size: 16.0))
                .foregroundStyle(.grey100)
            Spacer()
            
            Button(action: {
                action?()
            }, label: {
                HStack {
                    Text(model.value)
                        .font(Fonts.Pretendard.regular.swiftUIFont(size: 16.0))
                        .foregroundStyle(.grey80)
                    if model.modifiable {
                        Images.icChevronForward16.swiftUIImage
                    }
                        
                }
            })
            .tint(.grey80)
            .disabled(!model.modifiable)
        }
        .padding(.vertical, 12.0)
    }
}

#Preview {
    MyPageRowItemView(model: .init(title: "성별", value: "남자", modifiable: false, type: .gender), action: {
        print("Did tap button")
    })
}
