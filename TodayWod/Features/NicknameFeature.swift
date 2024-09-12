//
//  NicknameFeature.swift
//  TodayWod
//
//  Created by Davidyoon on 9/12/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct NicknameFeature {
    
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

import SwiftUI

struct NicknameInputView: View {
    var body: some View {
        VStack {
            Text("NickName")
        }
    }
}

#Preview {
    NicknameInputView()
}
