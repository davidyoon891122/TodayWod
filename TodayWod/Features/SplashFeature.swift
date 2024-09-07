//
//  SplashFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/7/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SplashFeature {

    @ObservableState
    struct State {
        let title: String = "TodayWod"
    }

    enum Action {
        case onAppear
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            }
        }
    }

}

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            Text("todayword")
                .bold()
                .font(.system(size: 26.0))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("SplashBackground"))
    }
}


#Preview {
    SplashView()
}
