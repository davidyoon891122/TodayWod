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

    @ObservableState
    struct State: Equatable {
        let title: String = "운동 루틴을 만들어보세요"
        let subTitle: String = "월요일부터 토요일까지 \n자동으로 새로운 운동 프로그램을 만들어요"
        let buttonTitle: String = "새로운 운동 만들기"
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
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 120.0, height: 120.0)
                .padding(.top, 120.0)
            
            Text(store.title)
                .bold()
                .font(.system(size: 20.0))
                .padding(.top, 30.0)
                
            Text(store.subTitle)
                .font(.system(size: 16.0))
                .padding(.top, 10.0)
                .multilineTextAlignment(.center)
            
            Button(action: {
                
            }, label: {
                Text(store.buttonTitle)
                    .bold()
                    .font(.system(size: 16.0))
            })
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 56.0)
            .background(.cyan)
            .clipShape(.rect(cornerRadius: 300.0))
            .padding(.horizontal, 38.0)
            .padding(.top, 40.0)
            
            Spacer()
        }
    }
    
}

#Preview {
    HomeView(store: Store(initialState: HomeFeature.State()) {
        HomeFeature()
    })
}
