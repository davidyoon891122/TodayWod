//
//  MyPageInfoView.swift
//  TodayWod
//
//  Created by 오지연 on 10/20/24.
//

import SwiftUI

struct MyPageInfoView: View {
    
    let model: OnboardingUserInfoModel?
    
    var body: some View {
        HStack(spacing: 4) {
            if model?.gender == .man {
                Images.genderMan.swiftUIImage
                    .resizable()
                    .frame(width: 48.0, height: 48.0)
            } else {
                Images.genderWoman.swiftUIImage
                    .resizable()
                    .frame(width: 48.0, height: 48.0)
            }
            VStack(alignment: .leading, spacing: 4.0) {
                Text(model?.nickName ?? "No name")
                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 20.0))
                    .foregroundStyle(.grey100)
                Text(model?.level?.title ?? "No Level")
                    .font(Fonts.Pretendard.regular.swiftUIFont(size: 12.0))
                    .foregroundStyle(.grey70)
            }

            Spacer()

            Images.icChevronForward16.swiftUIImage
        }
        .padding(.vertical, 12.0)
        .padding(.horizontal, 20.0)
        .contentShape(Rectangle())
    }
}
