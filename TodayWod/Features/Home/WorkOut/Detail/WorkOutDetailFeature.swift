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
        let item: WorkOutDayModel
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
            ScrollView {
                VStack {
                    WorkOutDetailTitleView(item: store.item)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(store.item.workOuts) { workOut in
                            Text(workOut.type.title)
                                .font(Fonts.Pretendard.bold.swiftUIFont(size: 16))
                                .foregroundStyle(Colors.grey100.swiftUIColor)
                                .frame(height: 40)
                                .padding(.top, 10)
                            
                            LazyVStack(alignment: .leading, spacing: 10) {
                                ForEach(workOut.items) { item in
                                    WodView(model: item)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            }
            .background(Colors.blue10.swiftUIColor)
        }
    }
    
}



#Preview {
    WorkOutDetailView(store: Store(initialState: WorkOutDetailFeature.State(item: WorkOutDayModel.fake)) {
        WorkOutDetailFeature()
    })
}
