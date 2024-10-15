//
//  WorkOutCompletedFeature.swift
//  TodayWod
//
//  Created by 오지연 on 10/4/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct WorkOutCompletedFeature {
    
    @ObservableState
    struct State: Equatable {
        let item: DayWorkoutModel
    }
    
    enum Action {
        case didTapCloseButton
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapCloseButton:
                return .run { _ in await dismiss() }
            }
        }
    }
    
}

import SwiftUI

struct WorkOutCompletedView: View {
    
    var store: StoreOf<WorkOutCompletedFeature>
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack(alignment: .leading) {
                    CustomNavigationView(type: .present) {
                        store.send(.didTapCloseButton)
                    }
                    
                    VStack(alignment: .leading) {
                        WorkOutCompletedTopView(item: store.item)
                        
                        Text(Constants.programTitle)
                            .font(Fonts.Pretendard.bold.swiftUIFont(size: 20.0))
                            .foregroundStyle(Colors.grey100.swiftUIColor)
                            .padding(.top, 40.0)
                            .padding(.bottom, 20.0)
                        
                        WorkOutCompletedProgramView(item: store.item)
                    }
                    .padding(.horizontal, 20.0)
                    .padding(.bottom, 73.0)
                    
                    BottomButton(title: Constants.closeTitle) {
                        store.send(.didTapCloseButton)
                    }
                    .padding(.bottom, 20.0)
                    .padding(.horizontal, 38.0)
                }
                
            }
            .background(Colors.blue10.swiftUIColor)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
}

private extension WorkOutCompletedView {
    
    enum Constants {
        static let programTitle = "프로그램"
        static let closeTitle = "닫기"
    }
    
}

#Preview {
    WorkOutCompletedView(store: .init(initialState: WorkOutCompletedFeature.State(item: .completedFake), reducer: {
        WorkOutCompletedFeature()
    }))
}
