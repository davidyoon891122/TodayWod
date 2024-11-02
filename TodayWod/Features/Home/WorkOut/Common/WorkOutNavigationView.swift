//
//  WorkOutNavigationView.swift
//  TodayWod
//
//  Created by 오지연 on 9/28/24.
//

import SwiftUI

struct WorkOutNavigationView: View {

    let duration: Int
    let isEnabled: Bool
    
    let backAction: (() -> Void)
    let doneAction: (() -> Void)

    var body: some View {
        HStack {
            Button(action: {
                backAction()
            }, label: {
                Images.icArrowBack24.swiftUIImage
            })
            .frame(width: 40, height: 40)
            
            Text(duration.timerFormatter)
                .font(Fonts.Pretendard.bold.swiftUIFont(size: 20))
                .foregroundStyle(Colors.grey100.swiftUIColor)
            
            Spacer()
            Button(action: {
                doneAction()
            }, label: {
                Text("운동종료")
                    .font(Fonts.Pretendard.regular.swiftUIFont(size: 13))
                    .foregroundStyle(isEnabled ? Colors.grey100.swiftUIColor : Colors.grey60.swiftUIColor)
            })
            .frame(width: 80, height: 40)
            .disabled(!isEnabled)
        }
        .padding(.horizontal, 12.0)
        .frame(height: 48.0)
    }
}


#Preview {
    WorkOutNavigationView(duration: 0, isEnabled: true, backAction: {
        print("didTapBackButton")
    }, doneAction: {
        print("didTapDoneButton")
    })
    .border(.gray)
}
