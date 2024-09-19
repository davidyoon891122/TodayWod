//
//  MethodDescriptionFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/16/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MethodDescriptionFeature {

    @ObservableState
    struct State: Equatable {
        let methodType: ProgramMethodType
        let buttonTitle: String = "닫기"
    }

    enum Action {
        case didTapBackButton
    }

    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapBackButton:
                return .run { _ in await dismiss() }
            }
        }
    }

}

import SwiftUI

struct MethodDescriptionView: View {

    let store: StoreOf<MethodDescriptionFeature>

    var body: some View {
        WithPerceptionTracking {
            VStack {
                HStack {
                    Text(store.methodType.title)
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 20.0))
                        .foregroundStyle(.grey100)
                    Spacer()
                }
                Text(store.methodType.description)
                    .font(Fonts.Pretendard.regular.swiftUIFont(size: 16.0))
                    .foregroundStyle(.grey80)
                    .padding(.top, 10.0)

            }
            .padding(.top, 30.0)
            .padding(.horizontal, 20.0)

            Button(action: {
                store.send(.didTapBackButton)
            }, label: {
                Text(store.buttonTitle)
                    .closeButtonStyle()
            })
            .padding(.top, 40.0)
            .padding(.bottom, 20.0)
            .padding(.horizontal, 38.0)
        }
    }

}

#Preview {
    MethodDescriptionView(store: Store(initialState: MethodDescriptionFeature.State(methodType: .body)) {
        MethodDescriptionFeature()
    })
}
