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
        @Shared(.appStorage(SharedConstants.isLaunchProgram)) var isLaunchProgram = false
    }
    
    enum Action {
        case didTapStartButton
        case requestResult(Result<ProgramEntity, Error>)
        case setProgramResult(Result<ProgramModel, Error>)
    }

    @Dependency(\.apiClient) var apiClient
    @Dependency(\.wodClient) var wodClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapStartButton:
                guard let method = state.onboardingUserModel?.method,
                        let level = state.onboardingUserModel?.level else { return .none }

                return .run { send in
                    do {
                        let result = try await apiClient.requestProgram(.init(methodType: method.rawValue, level: level.rawValue))

                        await send(.requestResult(.success(result)))
                    } catch {
                        await send(.requestResult(.failure(error)))
                    }
                }
            case .requestResult(.success(let entity)):
                return .run { send in
                    do {
                        let result = try await wodClient.addWodProgram(ProgramModel(data: entity))
                        await send(.setProgramResult(.success(result)))
                    } catch {
                        await send(.setProgramResult(.failure(error)))
                    }
                }
            case .requestResult(.failure(let error)):
                // TODO: - reqeust 에러 처리
                return .none
            case .setProgramResult(.success):
                state.isLaunchProgram = true
                return .none
            case .setProgramResult:
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
                
                Text(Constants.title)
                    .bold()
                    .font(.system(size: 20.0))
                    .padding(.top, 30.0)
                
                Text(Constants.subTitle)
                    .font(.system(size: 16.0))
                    .padding(.top, 10.0)
                    .multilineTextAlignment(.center)
                
                BottomButton(title: Constants.buttonTitle) {
                    store.send(.didTapStartButton)
                }
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
        static let title: String = "운동 루틴을 만들어보세요"
        static let subTitle: String = "월요일부터 토요일까지 \n자동으로 새로운 운동 프로그램을 만들어요"
        static let buttonTitle: String = "새로운 운동 만들기"
    }
    
}

#Preview {
    WorkOutEmptyView(store: Store(initialState: WorkOutEmptyFeature.State()) {
        WorkOutEmptyFeature()
    })
}
