//
//  GenderSelectFeature.swift
//  TodayWod
//
//  Created by Davidyoon on 9/12/24.
//

import Foundation
import ComposableArchitecture

enum GenderType {
    case man
    case woman
}

@Reducer
struct GenderSelectFeature {
    
    @ObservableState
    struct State: Equatable {
        let title: String = "나만의 운동 프로그램을\n설정할게요!"
        let subTitle: String = "성별을 선택해주세요."
        var gender: GenderType? = nil
    }
    
    enum Action {
        case setGender(GenderType)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .setGender(genderType):
                state.gender = genderType
                return .none
            }
        }
    }
    
}

import SwiftUI

struct GenderSelectView: View {
    
    let store: StoreOf<GenderSelectFeature>
    
    var body: some View {
        VStack {
            HStack {
                Text(store.title)
                    .bold()
                    .font(.system(size: 24.0))
                Spacer()
            }
            .padding(.top, 58.0)
            .padding(.horizontal, 20.0)
            HStack {
                Text(store.subTitle)
                    .font(.system(size: 20.0))
                    .foregroundStyle(.grey80)
                Spacer()
            }
            .padding(.top, 16.0)
            .padding(.horizontal, 20.0)
            
            HStack {
                Button(action: {
                    // TODO: set genderType to man
                    store.send(.setGender(.man))
                }, label: {
                    Images.genderMan.swiftUIImage
                        .resizable()
                        .frame(width: 160, height: 160)
                        .clipShape(.circle)
                        .opacity(store.gender == .man ? 1.0 : 0.6)
                })
                
                Button(action: {
                    // TODO: set genderType to woman
                    store.send(.setGender(.woman))
                }, label: {
                    Images.genderWoman.swiftUIImage
                        .resizable()
                        .frame(width: 160, height: 160)
                        .clipShape(.circle)
                        .opacity(store.gender == .woman ? 1.0 : 0.6)
                })
            }
            .padding(.top, 80.0)
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

#Preview {
    GenderSelectView(store: Store(initialState: GenderSelectFeature.State()) {
        GenderSelectFeature()
    })
}
