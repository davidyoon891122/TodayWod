//
//  SocialLoginFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/9/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SocialLoginFeature {

    @ObservableState
    struct State: Equatable {
        let title: String = "todaywod"
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

struct SocialLoginView: View {

    let store: StoreOf<SocialLoginFeature>

    var body: some View {
        VStack {
            Text(store.title)
                .bold()
                .font(.system(size: 26.0))
                .foregroundStyle(.white)
                .padding(.top, 179)

            Text("매일 매일 운동 와드를 손쉽게!")
                .bold()
                .font(.system(size: 18.0))
                .foregroundStyle(.white)
                .padding(.top, 39)
            Spacer()

            Button(action: {
                // Kakao Login action
            }, label: {
                ZStack {
                    Text("카카오톡으로 시작하기")
                        .bold()
                        .font(.system(size: 14.0))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.black)

                    Rectangle()
                        .foregroundStyle(.gray)
                        .frame(width: 24.0, height: 24.0)
                        .position(x: 32.0, y: 56.0 / 2)
                }
            })
            .frame(maxWidth: .infinity, maxHeight: 56.0)
            .background(.white)
            .clipShape(.rect(cornerRadius: 30))
            .padding(.horizontal, 38)

            Button(action: {
                // Kakao Login action
            }, label: {
                ZStack {
                    Text("Google로 시작하기")
                        .bold()
                        .font(.system(size: 14.0))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.black)

                    Rectangle()
                        .foregroundStyle(.gray)
                        .frame(width: 24.0, height: 24.0)
                        .position(x: 32.0, y: 56.0 / 2)
                }
            })
            .frame(maxWidth: .infinity, maxHeight: 56.0)
            .background(.white)
            .clipShape(.rect(cornerRadius: 30))
            .padding(.horizontal, 38)

            Button(action: {
                // Kakao Login action
            }, label: {
                ZStack {
                    Text("Apple로 시작하기")
                        .bold()
                        .font(.system(size: 14.0))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.black)

                    Rectangle()
                        .foregroundStyle(.gray)
                        .frame(width: 24.0, height: 24.0)
                        .position(x: 32.0, y: 56.0 / 2)
                }
            })
            .frame(maxWidth: .infinity, maxHeight: 56.0)
            .background(.white)
            .clipShape(.rect(cornerRadius: 30))
            .padding(.horizontal, 38)
            .padding(.bottom, 85)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Colors.splashBackground.swiftUIColor)
    }
}

#Preview {
    SocialLoginView(store: Store(initialState: SocialLoginFeature.State()) {
        SocialLoginFeature()
    })
}
