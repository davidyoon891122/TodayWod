//
//  BottomButton.swift
//  TodayWod
//
//  Created by 오지연 on 10/2/24.
//

import SwiftUI

struct BottomButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
                .frame(maxWidth: .infinity, minHeight: 56.0)
                .contentShape(Rectangle())
        })
        .bottomButtonStyle()
    }
    
}

#Preview {
    BottomButton(title: "시작하기") {
        print("버튼 클릭")
    }
}
