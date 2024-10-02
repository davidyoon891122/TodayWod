//
//  WorkOutEmptyView.swift
//  TodayWod
//
//  Created by 오지연 on 9/18/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct WorkOutEmptyFeature {
    
    @ObservableState
    struct State: Equatable {
        let onboardingUserModel = UserDefaultsManager().loadOnboardingUserInfo()
    }
    
    enum Action {
        case didTapStartButton
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapStartButton:
                return .none
            }
        }
    }
    
}


struct WorkOutEmptyView: View {
    
    let store: StoreOf<WorkOutEmptyFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                if store.state.onboardingUserModel?.gender == .man {
                    Images.genderMan.swiftUIImage
                        .resizable()
                        .frame(width: 120.0, height: 120.0)
                        .padding(.top, 120.0)
                } else {
                    Images.genderWoman.swiftUIImage
                        .resizable()
                        .frame(width: 120.0, height: 120.0)
                        .padding(.top, 120.0)
                }
                
                Text(Constants.Title)
                    .bold()
                    .font(.system(size: 20.0))
                    .padding(.top, 30.0)
                
                Text(Constants.SubTitle)
                    .font(.system(size: 16.0))
                    .padding(.top, 10.0)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    store.send(.didTapStartButton)
                }, label: {
                    Text(Constants.ButtonTitle)
                        .bottomButtonStyle()
                })
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 56.0)
                .background(.cyan)
                .clipShape(.rect(cornerRadius: 300.0))
                .padding(.horizontal, 38.0)
                .padding(.top, 40.0)
                
                Spacer()
            }
        }
    }
    
}

private extension WorkOutEmptyView {
    
    enum Constants {
        static let Title: String = "운동 루틴을 만들어보세요"
        static let SubTitle: String = "월요일부터 토요일까지 \n자동으로 새로운 운동 프로그램을 만들어요"
        static let ButtonTitle: String = "새로운 운동 만들기"
    }
    
}

#Preview {
    WorkOutEmptyView(store: Store(initialState: WorkOutEmptyFeature.State()) {
        WorkOutEmptyFeature()
    })
}
