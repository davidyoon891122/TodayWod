//
//  ToastView.swift
//  TodayWod
//
//  Created by Davidyoon on 11/11/24.
//

import SwiftUI

struct ToastView: View {
    
    let toast: ToastModel
    
    var body: some View {
        VStack {
            HStack {
                Text(toast.message)
                    .foregroundStyle(.white100)
                Spacer()
            }
            .padding(.horizontal, 20.0)
            .padding(.vertical, 14.0)
            .background(Colors.toastBG.swiftUIColor)
            .clipShape(.rect(cornerRadius: 300.0))
        }
        .padding(20.0)
    }
}

#Preview {
    ToastView(toast: .init(message: "토스트"))
}
