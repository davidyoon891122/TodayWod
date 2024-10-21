//
//  MyActivityEmptyView.swift
//  TodayWod
//
//  Created by 오지연 on 10/20/24.
//

import SwiftUI

struct MyActivityEmptyView: View {
    
    var body: some View {
        VStack(alignment: .center, spacing: 10.0) {
            Images.imgEmptyActivity.swiftUIImage
                .resizable()
                .frame(width: 180, height: 180)
            Text(Constants.title)
                .font(Fonts.Pretendard.regular.swiftUIFont(size: 16.0))
                .foregroundStyle(.grey70)
            Spacer()
        }
        .padding(.top, 16)
    }
    
}

private extension MyActivityEmptyView {
    
    enum Constants {
        static let title = "아직 시작한 운동이 없어요!"
    }
    
}

#Preview {
    MyActivityEmptyView()
}
