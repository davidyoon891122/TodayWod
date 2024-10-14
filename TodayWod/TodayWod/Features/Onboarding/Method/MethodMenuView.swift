//
//  MethodMenuView.swift
//  TodayWod
//
//  Created by Davidyoon on 10/8/24.
//

import ComposableArchitecture
import SwiftUI

struct MethodMenuView: View {
    
    @Perception.Bindable var store: StoreOf<MethodSelectFeature>
    
    var body: some View {
        WithPerceptionTracking {
            HStack {
                VStack {
                    Button(action: {
                        store.send(.setMethod(.body))
                    }, label: {
                        ZStack {
                            if store.state.onboardingUserModel.gender == .man {
                                Images.bodyManWeight.swiftUIImage
                                    .resizable()
                                    .frame(width: 160, height: 160)
                                    .clipShape(.circle)
                            } else {
                                Images.bodyWomanWeight.swiftUIImage
                                    .resizable()
                                    .frame(width: 160, height: 160)
                                    .clipShape(.circle)
                            }
                            Images.icCheck.swiftUIImage
                                .resizable()
                                .frame(width: 160.0, height: 160.0)
                                .opacity(store.methodType == .body ? 1.0 : 0.0)
                        }
                    })
                    Text(Constants.bodyMethodTitle)
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 18.0))
                        .foregroundStyle(.grey100)
                        .padding(.top, 20.0)
                    Button(action: {
                        store.send(.didTapBodyDescriptionButton)
                    }, label: {
                        HStack {
                            Images.icInfo16.swiftUIImage
                            Text(Constants.showDetail)
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
                            if store.state.onboardingUserModel.gender == .man {
                                Images.machineManWeight.swiftUIImage
                                    .resizable()
                                    .frame(width: 160, height: 160)
                                    .clipShape(.circle)
                            } else {
                                Images.machineWomanWeight.swiftUIImage
                                    .resizable()
                                    .frame(width: 160, height: 160)
                                    .clipShape(.circle)
                            }
                            Images.icCheck.swiftUIImage
                                .resizable()
                                .frame(width: 160.0, height: 160.0)
                                .opacity(store.methodType == .machine ? 1.0 : 0.0)
                        }
                    })
                    Text(Constants.machineMethodTitle)
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 18.0))
                        .foregroundStyle(.grey100)
                        .padding(.top, 20.0)
                    Button(action: {
                        store.send(.didTapMachineDescriptionButton)
                    }, label: {
                        HStack {
                            Images.icInfo16.swiftUIImage
                            Text(Constants.showDetail)
                                .font(Fonts.Pretendard.medium.swiftUIFont(size: 13.0))
                            
                        }
                        .tint(.grey80)
                    })
                    .padding(.top, 11.0)
                }
            }
            .padding(.top, 80.0)
            .padding(.horizontal)
        }
    }
    
}

private extension MethodMenuView {
    
    enum Constants {
        static let bodyMethodTitle: String = "맨몸 위주 운동"
        static let machineMethodTitle: String = "머신 위주 운동"
        static let showDetail: String = "자세히 보기"
    }
    
}

#Preview {
    MethodMenuView(store: Store(initialState: MethodSelectFeature.State(onboardingUserModel: .preview)) {
        MethodSelectFeature()
    })
}
