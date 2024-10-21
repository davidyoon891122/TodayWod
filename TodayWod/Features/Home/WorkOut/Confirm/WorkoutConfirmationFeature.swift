//
//  WorkoutConfirmationFeature.swift
//  TodayWod
//
//  Created by Davidyoon on 9/30/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct WorkoutConfirmationFeature {
    
    @ObservableState
    struct State: Equatable {
        let type: WorkoutConfirmationType
    }
    
    enum Action {
        case didTapDoneButton
        case didTapCloseButton
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapDoneButton:
                return .run { _ in await dismiss() }
            case .didTapCloseButton:
                return .run { _ in await dismiss() }
            }
        }
    }
    
}

import SwiftUI

struct WorkoutConfirmationView: View {
    
    let store: StoreOf<WorkoutConfirmationFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack(alignment: .leading) {
                Text(store.type.title)
                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 24.0))
                    .foregroundStyle(.grey100)

                Text(store.type.description)
                    .font(Fonts.Pretendard.regular.swiftUIFont(size: 16.0))
                    .foregroundStyle(.grey80)
                    .padding(.top, 10.0)

                HStack {
                    Button(action: {
                        store.send(.didTapCloseButton)
                    }, label: {
                        Text(store.type.cancelButtonTitle)
                            .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                            .foregroundStyle(.grey100)
                            .frame(maxWidth: .infinity, minHeight: 56.0)
                            .background(.grey20)
                            .clipShape(.rect(cornerRadius: 300.0))
                    })

                    Button(action: {
                        store.send(.didTapDoneButton)
                    }, label: {
                        Text(store.type.doneButtonTitle)
                            .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, minHeight: 56.0)
                            .background(.blue60)
                            .clipShape(.rect(cornerRadius: 300.0))
                    })
                }
                .padding(.top, 40.0)
            }
            .padding(.top, 30.0)
            .padding(.horizontal, 20.0)
            .padding(.bottom, 20.0)
            .background(.white)
        }
    }
    
}

#Preview {
    WorkoutConfirmationView(store: Store(initialState: WorkoutConfirmationFeature.State(type: .quit)) {
        WorkoutConfirmationFeature()
    })
}

#Preview {
    WorkoutConfirmationView(store: Store(initialState: WorkoutConfirmationFeature.State(type: .completed)) {
        WorkoutConfirmationFeature()
    })
}

