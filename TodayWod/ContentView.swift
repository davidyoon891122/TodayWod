//
//  ContentView.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/7/24.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {

    let store: StoreOf<SplashFeature>

    var body: some View {
        SplashView(store: store)
    }
}

#Preview {
    ContentView(store: Store(initialState: SplashFeature.State()) {
        SplashFeature()
    })
}
