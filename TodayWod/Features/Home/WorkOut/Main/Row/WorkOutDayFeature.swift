//
//  WorkOutDayFeature.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation
import SwiftUI

struct WorkOutDayView: View {
    
    let index: Int
    let item: WorkOutDayModel
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(spacing: 0) {
                Text(Constants.dayTitle + "\(index+1)")
                    .font(Fonts.Pretendard.regular.swiftUIFont(size: 11))
                    .foregroundStyle(Colors.grey100.swiftUIColor)
                    .padding(.vertical, 9)
                if let title = item.type.title {
                    Text(title)
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 11))
                        .foregroundStyle(.white)
                        .frame(width: 40, height: 26)
                        .background(Colors.blue60.swiftUIColor)
                        .cornerRadius(30)
                }
                CustomDivider(color: Colors.grey20.swiftUIColor, direction: .vertical)
            }
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(item.title)
                            .font(Fonts.Pretendard.extraBold.swiftUIFont(size: 16))
                            .foregroundStyle(Colors.grey100.swiftUIColor)
                        Text(item.subTitle)
                            .font(Fonts.Pretendard.regular.swiftUIFont(size: 13))
                            .foregroundStyle(Colors.grey80.swiftUIColor)
                    }
                    Spacer()
                    Images.genderMan.swiftUIImage
                        .resizable()
                        .frame(width: 48, height: 48)
                }
                
                HStack(spacing: 40) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(item.displayExpectedMinute)
                            .font(Fonts.Pretendard.bold.swiftUIFont(size: 13))
                            .foregroundStyle(Colors.grey100.swiftUIColor)
                        Text(Constants.expectedTimeTitle)
                            .font(Fonts.Pretendard.regular.swiftUIFont(size: 12))
                            .foregroundStyle(Colors.grey70.swiftUIColor)
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text(item.displayEstimatedCalorie)
                            .font(Fonts.Pretendard.bold.swiftUIFont(size: 13))
                            .foregroundStyle(Colors.grey100.swiftUIColor)
                        Text(Constants.expectedCalorieTitle)
                            .font(Fonts.Pretendard.regular.swiftUIFont(size: 12))
                            .foregroundStyle(Colors.grey70.swiftUIColor)
                    }
                }
            }
            .padding(16)
            .background(Colors.grey10.swiftUIColor)
            .cornerRadius(12.0, corners: .allCorners)
        }
        .padding(.horizontal, 20)
        .frame(height: 156)
    }
}

private extension WorkOutDayView {
    
    enum Constants {
        static let dayTitle: String = "Day "
        static let expectedTimeTitle: String = "예상 시간"
        static let expectedCalorieTitle: String = "예상 소모 칼로리"
    }
    
}

#Preview {
    WorkOutDayView(index: 0, item: WorkOutDayModel.fake)
}
