//
//  VersionInfoView.swift
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
        
    }
    
    enum Action {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            }
        }
    }
}

struct VersionInfoView: View {
    
    let version: String
    
    var body: some View {
        VStack {
            HStack {
                Text(Constants.title)
                    .font(Fonts.Pretendard.bold.swiftUIFont(size: 16.0))
                Spacer()
            }
            .padding(.top, 25.0)
            
            MyPageRowItemView(model: .init(title: "\(version)", value: Constants.menuTitle, type: .version))
            
        }
        .padding(.horizontal, 20.0)
        .padding(.bottom, 30.0)
    }
    
}

private extension VersionInfoView {
    
    enum Constants {
        static let title: String = "버전 정보"
        static let menuTitle: String = "최신버전"
    }
    
}

#Preview {
    VersionInfoView(version: "0.0.1")
}
