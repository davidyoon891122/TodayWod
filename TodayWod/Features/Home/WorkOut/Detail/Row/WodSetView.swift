//
//  WodSetView.swift
//  TodayWod
//
//  Created by 오지연 on 9/22/24.
//

import SwiftUI

struct WodSetView: View {
    
    let model: WodSet
    
    var body: some View {
        HStack {
            Text(model.displayUnitValue)
                .font(Fonts.Pretendard.bold.swiftUIFont(size: 18))
                .foregroundStyle(Colors.grey100.swiftUIColor)
                .frame(width: 48, height: 48)
                .roundedBorder(radius: 8, color: Colors.grey40)
            Spacer()
            Button {
                //
            } label: {
                model.isCompleted ? Images.icCheckBox.swiftUIImage : Images.icCheckEmpty.swiftUIImage
            }
            .frame(width: 48, height: 48)
        }
    }
    
}

#Preview {
    WodSetView(model: WodSet.fake)
}
