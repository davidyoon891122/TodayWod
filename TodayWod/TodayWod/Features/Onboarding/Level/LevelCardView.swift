//
//  LevelCardView.swift
//  TodayWod
//
//  Created by Davidyoon on 10/8/24.
//

import SwiftUI
import ComposableArchitecture

struct LevelCardView: View {

    let type: LevelType
    let isSelected: Bool

    var body: some View {
        VStack {
            HStack {
                Text("\(type.title)")
                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 18.0))
                    .foregroundStyle(isSelected ? .blue60 : .grey100)
                Spacer()
            }
            .padding(.horizontal, 16.0)
            .padding(.top, 16.0)
            HStack {
                Text("\(type.description)")
                    .font(Fonts.Pretendard.regular.swiftUIFont(size: 13.0))
                    .foregroundStyle(.grey80)
                Spacer()
            }
            .padding(.horizontal, 16.0)
            .padding(.top, 4.0)
            .padding(.bottom, 16.0)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(isSelected ? .blue60 : .grey40)
        }
        .padding(.horizontal, 20.0)
    }

}

#Preview {
    LevelCardView(type: .beginner, isSelected: true)
}


#Preview {
    LevelCardView(type: .advanced, isSelected: false)
}
