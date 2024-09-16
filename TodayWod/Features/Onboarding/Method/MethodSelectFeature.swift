//
//  MethodSelectFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/16/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MethodSelectFeature {

    @ObservableState
    struct State: Equatable {
        let title: String = "나만의 운동 프로그램을\n설정할게요!"
        let subTitle: String = "운동 방식을 선택해주세요."
        let buttonTitle: String = "시작하기"

        var isValidMethod: Bool = false
        var methodType: MethodType? = nil
        @Presents var methodDescription: MethodDescriptionFeature.State?
    }

    enum Action {
        case didTapStartButton
        case setMethod(MethodType)
        case methodDescriptionTap(PresentationAction<MethodDescriptionFeature.Action>)
        case didTapBodyDescriptionButton
        case didTapMachineDescriptionButton
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
            case .methodDescriptionTap:
                return .none
            case .didTapBodyDescriptionButton:
                state.methodDescription = MethodDescriptionFeature.State(methodType: .body)
                return .none
            case .didTapMachineDescriptionButton:
                state.methodDescription = MethodDescriptionFeature.State(methodType: .machine)
                return .none
            }
        }
        .ifLet(\.$methodDescription, action: \.methodDescriptionTap) {
            MethodDescriptionFeature()
        }
    }

}

import SwiftUI

struct MethodSelectView: View {

    @Perception.Bindable var store: StoreOf<MethodSelectFeature>

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
                        store.send(.didTapBodyDescriptionButton)
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
                        store.send(.didTapMachineDescriptionButton)
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
        .sheet(item: $store.scope(state: \.methodDescription, action: \.methodDescriptionTap)) { store in
            MethodDescriptionView(store: store)
                .presentationDetents([.medium, .large])
        }
    }

}

#Preview {
    MethodSelectView(store: Store(initialState: MethodSelectFeature.State()) {
        MethodSelectFeature()
    })
}

