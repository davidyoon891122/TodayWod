//
//  HomeFeature.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/8/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct HomeFeature {

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

struct HomeView: View {

    let store: StoreOf<HomeFeature>

    var body: some View {
        VStack {
            Text("Home")
        }
    }
    
}
