//
//  CalendarView.swift
//  TodayWod
//
//  Created by Davidyoon on 9/20/24.
//

import SwiftUI

struct CalendarView: View {
    
    @State var month: Date
    @Binding var markedDates: Set<Date>
    @State private var offset: CGSize = CGSize()
    
    var body: some View {
        VStack {
            CalendarHeaderView(month: month)
            CalendarGridView(month: month, markedDates: $markedDates)
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                }
                .onEnded { gesture in
                    if gesture.translation.width < -100 {
                        month = month.changeMonth(by: 1)
                    } else if gesture.translation.width > 100 {
                        month = month.changeMonth(by: -1)
                    }
                    self.offset = CGSize()
                }
        )
    }

}

#Preview {
    CalendarView(month: Date(), markedDates: .constant([Date()]))
}
