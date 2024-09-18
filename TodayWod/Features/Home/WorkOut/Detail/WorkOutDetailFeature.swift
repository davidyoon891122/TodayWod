//
//  WorkOutDetailFeature.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct WorkOutDetailFeature {
    
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

struct WorkOutDetailView: View {
    
    let store: StoreOf<WorkOutDetailFeature>
    
    var body: some View {
        WithPerceptionTracking {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    WorkOutDetailView(store: Store(initialState: WorkOutDetailFeature.State()) {
        WorkOutDetailFeature()
    })
}
