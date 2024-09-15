//
//  CustomNavigationView.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/15/24.
//

import SwiftUI

struct CustomNavigationView: View {

    let action: (() -> Void)

    var body: some View {
        HStack {
            Button(action: {
                action()
            }, label: {
                Images.icArrowBack24.swiftUIImage

            })
            .padding(.horizontal, 8.0)
            Spacer()
        }
        .padding(.horizontal, 12.0)
        .frame(height: 48.0)
    }
}


#Preview {
    CustomNavigationView {
        print("Did tap back button")
    }
    .border(.gray)
}
