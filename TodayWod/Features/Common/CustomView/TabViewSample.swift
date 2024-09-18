//
//  TabViewSample.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/18/24.
//

import SwiftUI
import ComposableArchitecture

struct TabViewSample: View {

    @State private var selectedItem: TabMenuItem = .home

    var body: some View {
        VStack {
            switch selectedItem {
            case .home:
                HomeView(store: Store(initialState: HomeFeature.State()) {
                    HomeFeature()
                })
            case .settings:
                SettingsView(store: Store(initialState: SettingsFeature.State()){
                    SettingsFeature()
                })
            }
            Spacer()
            CustomTabView(selectedItem: $selectedItem)
                .padding(.bottom, 20)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
}

#Preview {
    TabViewSample()
}
