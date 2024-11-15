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
        let url: String = "itms-apps://itunes.apple.com/app/6677019235" // 여기에 선언하는게 맞을지 ? 고민
    }
    
    enum Action {
        case didTapUpdate
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapUpdate:
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
                        UIApplication.shared.open(URL(string: store.url)!)
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
