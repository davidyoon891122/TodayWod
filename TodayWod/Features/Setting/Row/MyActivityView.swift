//
//  MyActivityView.swift
//  TodayWod
//
//  Created by 오지연 on 10/20/24.
//

import SwiftUI

struct MyActivityView: View {

    let model: DayWorkoutModel
    
    var body: some View {
        HStack(spacing: 8.0) {
            model.imageName.toSwiftUIImage
                .resizable()
                .frame(width: 48.0, height: 48.0)
            VStack(alignment: .leading, spacing: 6.0) {
                HStack {
                    Text(model.title)
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                        .foregroundStyle(.grey100)
                    Spacer()
                    Text(model.duration.timerFormatter)
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                        .foregroundStyle(.grey100)
                }
                Text(model.displayDate)
                    .font(Fonts.Pretendard.regular.swiftUIFont(size: 13.0))
                    .foregroundStyle(.grey70)
            }
            Spacer()
        }
        .padding(20.0)
        .background(.grey10)
        .clipShape(.rect(cornerRadius: 12.0))
        .padding(.horizontal, 20.0)
    }
    
}

#Preview {
    MyActivityView(model: DayWorkoutModel.fake)
}
