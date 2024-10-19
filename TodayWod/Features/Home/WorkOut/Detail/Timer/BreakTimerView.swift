//
//  BreakTimerView.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/21/24.
//

import Foundation
import ComposableArchitecture

import SwiftUI
struct BreakTimerView: View {

    let store: StoreOf<WorkOutDetailFeature>

    var body: some View {
        WithPerceptionTracking {
            
            VStack {
                HStack {
                    Text("휴식")
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                    
                    Text("\(store.state.currentSeconds) 초")
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 28.0))
                    Spacer()
                    Button(action: {
                        store.send(.didTapReset)
                    }, label: {
                        Images.icRefresh24.swiftUIImage
                    })
                    
                    Button(action: {
                        store.send(.setButtonState)
                    }, label: {
                        if (store.buttonState == .pause) {
                            Images.icPause24.swiftUIImage
                        } else {
                            Images.icPlay24.swiftUIImage
                        }
                        
                    })
                }
                .padding(.horizontal, 20.0)
                .padding(.vertical, 20.0)
                .background(.white)
                .clipShape(.rect(cornerRadius: 16.0))
            }
            .padding(20.0)
            .background(.blue20)

        }
    }

}

#Preview {
    BreakTimerView(store: Store(initialState: WorkOutDetailFeature.State(item: .fake)) {
        WorkOutDetailFeature()
    })
}
