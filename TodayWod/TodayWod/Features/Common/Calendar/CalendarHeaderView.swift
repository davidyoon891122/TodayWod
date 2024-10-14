//
//  CalendarHeaderView.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/22/24.
//

import SwiftUI

struct CalendarHeaderView: View {

    let month: Date

    var body: some View {
        VStack {
            HStack {
                Text(month.toCalendarMonth)
                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                Spacer()
            }
            .padding(.vertical, 4.0)
            .padding(.horizontal, 1.0)
            
            HStack {
                ForEach(Self.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(Fonts.Pretendard.medium.swiftUIFont(size: 12.0))
                        .foregroundStyle(symbol == "일" ? .red : .gray)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 20.0)
            .padding(.bottom, 5.0)
        }
    }
}

extension CalendarHeaderView {

    static var weekdaySymbols: [String] = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ko_KR")
        return calendar.veryShortWeekdaySymbols
    }()

}

#Preview {
    CalendarHeaderView(month: Date())
}
