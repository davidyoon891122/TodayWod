//
//  WodView.swift
//  TodayWod
//
//  Created by 오지연 on 9/21/24.
//

import Foundation
import SwiftUI

struct WodView: View {
    
    let model: WodModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                titleView
                
                headerView
                
                LazyVStack(spacing: 10) {
                    ForEach(Array(model.set.enumerated()), id: \.element.id) { index, set in
                        HStack(spacing: 10) {
                            if model.isShowSet {
                                Text(String(index + 1))
                                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 18))
                                    .foregroundStyle(Colors.grey100.swiftUIColor)
                                    .frame(width: 48)
                            }
                            WodSetView(model: set)
                        }
                    }
                }
            }
            .padding(20)
        }
        .background(.white)
        .cornerRadius(12, corners: .allCorners)
    }
    
    var titleView: some View {
        VStack(alignment: .leading) {
            Text(model.title)
                .font(Fonts.Pretendard.bold.swiftUIFont(size: 20))
                .foregroundStyle(Colors.grey100.swiftUIColor)
                .frame(height: 28)
            Text(model.subTitle)
                .font(Fonts.Pretendard.bold.swiftUIFont(size: 16))
                .foregroundStyle(Colors.grey70.swiftUIColor)
        }
        .padding(.bottom, 20)
    }
    
    var headerView: some View {
        HStack(spacing: 10) {
            if model.isShowSet {
                Text(model.displaySet)
                    .font(Fonts.Pretendard.medium.swiftUIFont(size: 12))
                    .foregroundStyle(Colors.grey100.swiftUIColor)
            }
            Text(model.unit.title)
                .font(Fonts.Pretendard.medium.swiftUIFont(size: 12))
                .foregroundStyle(Colors.grey100.swiftUIColor)
            Spacer()
            Text("완료")
                .font(Fonts.Pretendard.medium.swiftUIFont(size: 12))
                .foregroundStyle(Colors.grey100.swiftUIColor)
                .frame(width: 48)
        }
        
        .padding(.bottom, 10)
    }
    
}

#Preview {
    WodView(model: WodModel.fake)
}
