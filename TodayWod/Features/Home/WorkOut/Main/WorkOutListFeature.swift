//
//  WorkOutListFeature.swift
//  TodayWod
//
//  Created by Davidyoon on 10/11/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct WorkOutListFeature {
    
    @ObservableState
    struct State {
        
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
struct WorkOutListView: View {
    
    var body: some View {
        VStack {
            Text("WorkOutListView")
        }
    }
    
}
