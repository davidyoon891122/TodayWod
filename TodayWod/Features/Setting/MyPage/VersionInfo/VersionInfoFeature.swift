//
//  VersionInfoFeature.swift
//  TodayWod
//
//  Created by Davidyoon on 9/25/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct VersionInfoFeature {
    
    @ObservableState
    struct State: Equatable {
        var version: String
        var shouldUpdate: Bool = false
        var versionInfo: String = "최신버전"
    }
    
    enum Action {
        case onAppear
        case didTapUpdate
        case versionRequestResult(Result<VersionInfoModel, Error>)
    }
    
    @Dependency(\.apiClient) var apiClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                let bundleId = PlistReader().identifier // "com.ycompany.DreamTodo"
                return .run { send in
                    do {
                        let result = try await apiClient.requestAppVersion(.init(bundleId: bundleId))
                        
                        await send(.versionRequestResult(.success(result)))
                    } catch {
                        await send(.versionRequestResult(.failure(error)))
                    }
                }
            case .didTapUpdate:
                guard let url = URL(string: "itms-apps://itunes.apple.com/app/6677019235") else { return .none }
                UIApplication.shared.open(url)
                return .none
            case .versionRequestResult(.success(let result)):
                if let currentVersion = VersionInfoModel(from: state.version) {
                    state.shouldUpdate = result > currentVersion
                }
                return .none
            case .versionRequestResult(.failure(_)):
                state.versionInfo = ""
                return .none
            }
        }
    }
}

struct VersionInfoView: View {
    
    let store: StoreOf<VersionInfoFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                HStack {
                    Text(Constants.title)
                        .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                    Spacer()
                }
                .padding(.top, 25.0)
                
                HStack {
                    Text(store.version)
                        .font(Fonts.Pretendard.regular.swiftUIFont(size: 16.0))
                        .foregroundStyle(.grey100)
                    Spacer()
                    
                    Button(action: {
                        store.send(.didTapUpdate)
                    }, label: {
                        if store.shouldUpdate {
                            HStack {
                                Text(Constants.updateTitle)
                                    .foregroundStyle(.blue60)
                                Images.icChevronForward16.swiftUIImage
                            }
                        } else {
                            HStack {
                                Text(store.versionInfo)
                                    .font(Fonts.Pretendard.regular.swiftUIFont(size: 16.0))
                                    .foregroundStyle(.grey80)
                            }
                        }
                    })
                    .tint(.grey80)
                    .disabled(!store.shouldUpdate)
                }
                .padding(.vertical, 12.0)
            }
            .padding(.horizontal, 20.0)
            .padding(.bottom, 30.0)
            .onAppear {
                store.send(.onAppear)
            }
        }
    }
    
}

private extension VersionInfoView {
    
    enum Constants {
        static let title: String = "버전 정보"
        static let updateTitle: String = "업데이트"
    }
    
}

#Preview {
    VersionInfoView(store: .init(initialState: VersionInfoFeature.State(version: "0.0.1")) {
        VersionInfoFeature()
    })
}

#Preview {
    VersionInfoView(store: .init(initialState: VersionInfoFeature.State(version: "0.0.1")) {
        VersionInfoFeature()
    })
}
