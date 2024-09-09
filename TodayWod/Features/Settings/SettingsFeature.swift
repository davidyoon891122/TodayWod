//
//  SettingsFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/8/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SettingsFeature {

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

import SwiftUI

struct SettingsView: View {

    let store: StoreOf<SettingsFeature>

    var body: some View {
        VStack {
            Text("Settings")
        }
    }

}

#Preview {
    SettingsView(store: Store(initialState: SettingsFeature.State()){
        SettingsFeature()
    })
}
