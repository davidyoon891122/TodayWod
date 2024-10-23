//
//  CalendarView.swift
//  TodayWod
//
//  Created by Davidyoon on 9/20/24.
//

import SwiftUI

struct CalendarView: View {
    
    @State private var offset: CGSize = CGSize()
    
    var month: Date
    @Binding var markedDates: Set<Date>
    
    var body: some View {
        VStack {
            CalendarHeaderView(month: month)
            CalendarGridView(month: month, markedDates: $markedDates)
        }
    }

}

#Preview {
    CalendarView(month: Date(), markedDates: .constant([Date()]))
}
