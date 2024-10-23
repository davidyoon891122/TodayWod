//
//  CalendarGridView.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/22/24.
//

import SwiftUI

struct CalendarGridView: View {

    let month: Date
    @Binding var markedDates: Set<Date>

    var body: some View {

        let daysInMonth = month.numberOfDays
        let firstWeekday = month.firstWeekdayOfMonth - 1 // 0-based index
        let totalDays = firstWeekday + daysInMonth
        let totalCellsNeeded = ((totalDays + 6) / 7) * 7 // 전체 셀 수를 7의 배수로 맞춤

        let daysInPreviousMonth = month.previouseMonth.numberOfDays

        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(0 ..< totalCellsNeeded, id: \.self) { index in
                    if index < firstWeekday {
                        // 이전 달의 일자 표시
                        let day = daysInPreviousMonth - (firstWeekday - index - 1)
                        CalendarCellView(day: day, isCurrentMonth: false)
                    } else if index < firstWeekday + daysInMonth {
                        // 현재 달의 일자 표시
                        let day = index - firstWeekday + 1
                        let date = getDate(for: day - 1, month: month)
                        let marked = isDateMarked(date)

                        CalendarCellView(day: day, marked: marked)
                    } else {
                        // 다음 달의 일자 표시
                        let day = index - (firstWeekday + daysInMonth) + 1
                        CalendarCellView(day: day, isCurrentMonth: false)
                    }
                }
            }
        }
    }

}

extension CalendarGridView {

    func getDate(for day: Int, month: Date) -> Date {
        Calendar.current.date(byAdding: .day, value: day, to: month.startOfMonth)!
    }

    func isDateMarked(_ date: Date) -> Bool {
        markedDates.contains { markedDate in
            Calendar.current.isDate(markedDate, equalTo: date, toGranularity: .day)
        }
    }

}


#Preview {
    CalendarGridView(month: Date(), markedDates: .constant([Date()]))
}
