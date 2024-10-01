//
//  WorkOutDetailTitleView.swift
//  TodayWod
//
//  Created by 오지연 on 9/22/24.
//

import SwiftUI

struct WorkOutDetailTitleView: View {
    
    let item: WorkOutDayModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text(item.title)
                .font(Fonts.Pretendard.bold.swiftUIFont(size: 20))
                .foregroundStyle(Colors.grey100.swiftUIColor)
            
            HStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.displayExpectedMinute)
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 18))
                        .foregroundStyle(Colors.grey100.swiftUIColor)
                    Text(item.displayExpectedMinuteTitle)
                        .font(Fonts.Pretendard.regular.swiftUIFont(size: 12))
                        .foregroundStyle(Colors.grey70.swiftUIColor)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.displayEstimatedCalorie)
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 18))
                        .foregroundStyle(Colors.grey100.swiftUIColor)
                    Text(item.displayEstimatedCalorieTitle)
                        .font(Fonts.Pretendard.regular.swiftUIFont(size: 12))
                        .foregroundStyle(Colors.grey70.swiftUIColor)
                }
                Spacer()
            }
        }
        .padding(20)
        .background(.white)
        .cornerRadius(12, corners: .allCorners)
        .padding(.vertical, 10)
    }
    
}

#Preview {
    VStack {
        Spacer()
        WorkOutDetailTitleView(item: WorkOutDayModel.fake)
        Spacer()
    }
    .background(.blue10)
}
