//
//  Extension+Date.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/22/24.
//

import Foundation

extension Date {

    var toString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 MM월 dd일 EEEE"
        return formatter.string(from: self)
    }
    
    var toCalendarMonth: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월"
        return formatter.string(from: self)
    }

    var numberOfDays: Int {
        Calendar.current.range(of: .day, in: .month, for: self)?.count ?? 0
    }

    var firstWeekdayOfMonth: Int {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        let firstDayOfMonth = Calendar.current.date(from: components)!

        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }

    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }

    func changeMonth(by value: Int) -> Date {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: self) {
            return newMonth
        } else {
            return self
        }
    }

    var previouseMonth: Date {
        Calendar.current.date(byAdding: .month, value: -1, to: self)!
    }

}
