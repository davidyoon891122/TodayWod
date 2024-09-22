//
//  CalendarCellView.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/22/24.
//

import SwiftUI

struct CalendarCellView: View {
    var day: Int
    var marked: Bool = false
    var isCurrentMonth: Bool = true

    init(day: Int, marked: Bool = false, isCurrentMonth: Bool = true) {
        self.day = day
        self.marked = marked
        self.isCurrentMonth = isCurrentMonth
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5.0)
                .opacity(0)
                .overlay {
                    Text("\(day)")
                        .font(Fonts.Pretendard.medium.swiftUIFont(size: 13.0))
                        .foregroundColor(isCurrentMonth ? .black : .gray)
                }

            if marked && isCurrentMonth {
                Images.icCircleCheckOpacity80.swiftUIImage
            }
        }
        .frame(width: 32.0, height: 32.0)
        .padding(8.0)
    }
}

#Preview {
    CalendarCellView(day: 1, marked: false, isCurrentMonth: false)
}
