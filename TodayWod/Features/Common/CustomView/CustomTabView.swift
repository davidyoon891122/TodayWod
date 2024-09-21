//
//  CustomTabView.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/18/24.
//

import SwiftUI

struct CustomTabView: View {

    @Binding var selectedItem: TabMenuItem

    var body: some View {
        HStack {
            ForEach(TabMenuItem.allCases, id: \.self) { type in
                Button(action: {
                    selectedItem = type
                }, label: {
                    VStack {
                        Color(selectedItem == type ? .white : .blue10)
                            .frame(width: 48.0, height: 38.0)
                            .clipShape(.rect(cornerRadius: 40))
                            .overlay {
                                selectedItem == type ? type.selectedImage : type.deactivatedImage
                            }
                    }
                    .frame(maxWidth: .infinity)
                })
                .frame(maxWidth: .infinity)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 58)
        .background(.blue10)
    }
}

#Preview {
    VStack {
        Text("Hello")
        CustomTabView(selectedItem: .constant(.home))
    }
    .background(.black)
}
