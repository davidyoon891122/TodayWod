//
//  Extension+View.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 10/23/24.
//

import SwiftUI

extension View {

    func measureHeight(_ height: @escaping (CGFloat) -> Void) -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: HeightPreferenceKey.self, value: geometry.size.height)
                    .onPreferenceChange(HeightPreferenceKey.self) { newHeight in
                        height(newHeight)
                    }
            }
        )
    }

}
