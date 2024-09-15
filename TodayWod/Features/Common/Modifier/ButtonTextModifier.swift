//
//  ButtonTextModifier.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/15/24.
//

import SwiftUI

struct ButtonTextModifier: ViewModifier {

    @Environment(\.isEnabled) var isEnabled

    func body(content: Content) -> some View {
        content
            .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
            .frame(maxWidth: .infinity, minHeight: 56.0)
            .background(isEnabled ? .blue60 : .blue20)
            .clipShape(.rect(cornerRadius: 300.0))
            .foregroundStyle(.white)
    }

}

extension View {

    func nextButtonStyle() -> some View {
        self.modifier(ButtonTextModifier())
    }

}
