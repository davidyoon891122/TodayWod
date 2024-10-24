//
//  CustomTabView.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/18/24.
//

import SwiftUI

struct CustomTabView: View {

    @Binding var tabType: TabMenuType

    var body: some View {
        HStack {
            ForEach(TabMenuType.allCases, id: \.self) { type in
                Button(action: {
                    tabType = type
                }, label: {
                    VStack {
                        Color(tabType == type ? .white : .blue10)
                            .frame(width: 48.0, height: 38.0)
                            .clipShape(.rect(cornerRadius: 40))
                            .overlay {
                                tabType == type ? type.selectedImage : type.deactivatedImage
                            }
                    }
                    .frame(maxWidth: .infinity)
                })
                .frame(maxWidth: .infinity)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 58)
        .padding(.bottom, 20.0)
        .background(.blue10)
    }
}

#Preview {
    VStack {
        Text("Hello")
        CustomTabView(tabType: .constant(.home))
    }
    .background(.black)
}
