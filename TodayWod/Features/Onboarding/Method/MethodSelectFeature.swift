//
//  MethodSelectFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/16/24.
//

import Foundation
import ComposableArchitecture

enum MethodType {
    case body
    case machine
}

@Reducer
struct MethodSelectFeature {

    @ObservableState
    struct State: Equatable {
        let title: String = "나만의 운동 프로그램을\n설정할게요!"
        let subTitle: String = "운동 방식을 선택해주세요."
        let buttonTitle: String = "시작하기"

        var isValidMethod: Bool = false
        var methodType: MethodType? = nil
    }

    enum Action {
        case didTapStartButton
        case setMethod(MethodType)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapStartButton:
                return .none
            case let .setMethod(methodType):
                state.methodType = methodType
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.prepare()
                generator.impactOccurred()

                if let _ = state.methodType {
                    state.isValidMethod = true
                }

                return .none
            }
        }
    }

}

import SwiftUI

struct MethodSelectView: View {

    let store: StoreOf<MethodSelectFeature>

    var body: some View {
        VStack {
            HStack {
                Text(store.title)
                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 24.0))
                    .foregroundStyle(.grey100)
                    .lineLimit(2)
                Spacer()
            }
            .padding(.top, 58.0)
            .padding(.horizontal, 20.0)
            HStack {
                Text(store.subTitle)
                    .font(Fonts.Pretendard.regular.swiftUIFont(size: 20.0))
                    .foregroundStyle(.grey80)
                    .lineLimit(1)
                Spacer()
            }
            .padding(.top, 16.0)
            .padding(.horizontal, 20.0)

            HStack {
                VStack {
                    Button(action: {
                        store.send(.setMethod(.body))
                    }, label: {
                        ZStack {
                            Images.bodyWeight.swiftUIImage
                                .resizable()
                                .frame(width: 160, height: 160)
                                .clipShape(.circle)
                            Images.icCheck.swiftUIImage
                                .resizable()
                                .frame(width: 160.0, height: 160.0)
                                .opacity(store.methodType == .body ? 1.0 : 0.0)
                        }
                    })
                    Text("맨몸 위주 운동")
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 18.0))
                        .foregroundStyle(.grey100)
                        .padding(.top, 20.0)
                    Button(action: {

                    }, label: {
                        HStack {
                            Images.icInfo16.swiftUIImage
                            Text("자세히 보기")
                                .font(Fonts.Pretendard.medium.swiftUIFont(size: 13.0))

                        }
                        .tint(.grey80)
                    })
                    .padding(.top, 11.0)
                }
                VStack {

                    Button(action: {
                        store.send(.setMethod(.machine))
                    }, label: {
                        ZStack {
                            Images.machineWeight.swiftUIImage
                                .resizable()
                                .frame(width: 160, height: 160)
                                .clipShape(.circle)
                            Images.icCheck.swiftUIImage
                                .resizable()
                                .frame(width: 160.0, height: 160.0)
                                .opacity(store.methodType == .machine ? 1.0 : 0.0)
                        }
                    })
                    Text("머신 위주 운동")
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 18.0))
                        .foregroundStyle(.grey100)
                        .padding(.top, 20.0)
                    Button(action: {

                    }, label: {
                        HStack {
                            Images.icInfo16.swiftUIImage
                            Text("자세히 보기")
                                .font(Fonts.Pretendard.medium.swiftUIFont(size: 13.0))

                        }
                        .tint(.grey80)
                    })
                    .padding(.top, 11.0)
                }
            }
            .padding(.top, 80.0)
            .padding(.horizontal)

            Spacer()

            Button(action: {
                store.send(.didTapStartButton)
            }, label: {
                Text(store.buttonTitle)
                    .nextButtonStyle()
            })
            .disabled(!store.isValidMethod)
            .padding(.bottom, 20.0)
            .padding(.horizontal, 38.0)
        }
    }

}

#Preview {
    MethodSelectView(store: Store(initialState: MethodSelectFeature.State()) {
        MethodSelectFeature()
    })
}

