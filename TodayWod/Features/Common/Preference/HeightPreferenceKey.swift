//
//  HeightPreferenceKey.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 10/23/24.
//

import SwiftUI

struct HeightPreferenceKey: PreferenceKey {

    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }

}
