//
//  CelebrateFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/25/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CelebrateFeature {

    @ObservableState
    struct State: Equatable {

    }

    enum Action {

    }


    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {

            }
        }
    }

}

import SwiftUI

struct CelebrateView: View {

    let store: StoreOf<CelebrateFeature>

    var body: some View {
        VStack {
            Images.trophy.swiftUIImage
                .resizable()
                .frame(width: 120.0, height: 120.0)
                .padding(.top, 30.0)

            Text("승리의 순간이에요!")
                .font(Fonts.Pretendard.bold.swiftUIFont(size: 24.0))
                .foregroundStyle(.grey100)
                .padding(.top, 20.0)

            Text("6일간의 여정을 모두 정복했어요.\n이제 어떤 도전도 당신을 막을 수 없어요!")
                .font(Fonts.Pretendard.regular.swiftUIFont(size: 16.0))
                .foregroundStyle(.grey80)
                .multilineTextAlignment(.center)
                .padding(.top, 10.0)

            HStack {
                Button(action: {
                    // TODO: - did tap close
                }, label: {
                    Text("닫기")
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                        .foregroundStyle(.grey100)
                        .frame(maxWidth: .infinity, minHeight: 56.0)
                        .background(.grey20)
                        .clipShape(.rect(cornerRadius: 300.0))
                })

                Button(action: {
                    // TODO: - did tap new challenge
                }, label: {
                    Text("새로운 도전하기")
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, minHeight: 56.0)
                        .background(.blue60)
                        .clipShape(.rect(cornerRadius: 300.0))

                })
            }
            .padding(.horizontal, 20.0)
            .padding(.top, 40.0)
            .padding(.bottom, 20.0)
        }
        .background(.white)
    }

}

#Preview {
    CelebrateView(store: Store(initialState: CelebrateFeature.State()) {
        CelebrateFeature()
    })
}
