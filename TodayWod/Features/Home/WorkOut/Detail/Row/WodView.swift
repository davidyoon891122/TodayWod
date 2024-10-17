//
//  WodView.swift
//  TodayWod
//
//  Created by 오지연 on 9/21/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct WodView: View {
    
    @Perception.Bindable var store: StoreOf<WorkOutDetailFeature>
    let model: WodModel
    
    var body: some View {
        WithPerceptionTracking {
            VStack(alignment: .leading) {
                titleView
                
                headerView
                
                VStack(spacing: 10) {
                    ForEach(model.wodSets) { set in
                        HStack(spacing: 10) {
                            if model.isOrderSetVisible { // 세트 반복.
                                WodSetView(store: store, model: set)
                            } else {
                                WodSetDefaultView(store: store, model: set)
                            }
                        }
                    }
                }
            }
            .padding(20)
            .background(.white)
            .cornerRadius(12, corners: .allCorners)
        }
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
            if model.isOrderSetVisible {
                Text(model.displaySet)
                    .font(Fonts.Pretendard.medium.swiftUIFont(size: 12))
                    .foregroundStyle(Colors.grey100.swiftUIColor)
            }
            Text(model.unit.displayTitle)
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
    VStack {
        Spacer()
        WodView(store: Store(initialState: WorkOutDetailFeature.State(item: DayWorkoutModel.fake), reducer: {
            WorkOutDetailFeature()
        }), model: WodModel.fake)
        Spacer()
    }
    .background(.blue10)
}
