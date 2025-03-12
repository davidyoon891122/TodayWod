//
//  WodFeatureTests.swift
//  TodayWod
//
//  Created by 오지연 on 3/11/25.
//

import Testing
import Foundation
import ComposableArchitecture

@testable import TodayWod

@MainActor
struct WodFeatureTests {
    
    @Test
    func didTapOpenYoutube() async {
        var capturedURL: ApplicationURL?
        
        let store = TestStore(initialState: WodFeature.State(hasStart: false, model: WodModel.fake)) {
            WodFeature()
        } withDependencies: {
            $0.applicationLoaderClient = .testValue

            $0.applicationLoaderClient.open = { url in
                capturedURL = url
            }
        }
        
        store.exhaustivity = .off
        
        await store.send(.view(.didTapOpenYoutube))
        
        #expect(capturedURL?.url == ApplicationURL.youtube(query: WodModel.fake.title).url)
    }
    
    @Test
    func addWodSet() async {
        let store = TestStore(initialState: WodFeature.State(hasStart: false, model: WodModel.fake)) {
            WodFeature()
        }
        
        store.exhaustivity = .off
        
        #expect(store.state.model.wodSets.count == 2)
        
        await store.send(.view(.didTapAddWodSet)) {
            #expect($0.model.wodSets.count == 3)
        }
    }
    
    @Test
    func removeWodSet() async {
        let store = TestStore(initialState: WodFeature.State(hasStart: false, model: WodModel.fake)) {
            WodFeature()
        }
        
        store.exhaustivity = .off
        
        #expect(store.state.model.wodSets.count == 2)
        
        await store.send(.view(.didTapRemoveWodSet)) {
            #expect($0.model.wodSets.count == 1)
        }
    }
    
}
