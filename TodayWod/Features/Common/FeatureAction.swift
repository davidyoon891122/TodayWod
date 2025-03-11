//
//  FeatureAction.swift
//  TodayWod
//
//  Created by 오지연 on 2/26/25.
//
import Foundation
import ComposableArchitecture

protocol FeatureAction {
    
    associatedtype ViewAction     // View 에서 사용되는 Action
    associatedtype InnerAction    // 내부적으로 사용되는 Action
    associatedtype ScopeAction    // 자식 Reducer 에서 사용되는 Action
    associatedtype DelegateAction // 부모 Reducer 에서 사용되는 Action
    
    static func view(_: ViewAction) -> Self
    static func inner(_: InnerAction) -> Self
    static func scope(_: ScopeAction) -> Self
    static func delegate(_: DelegateAction) -> Self
    
}

extension Store where Action: FeatureAction {
    
    func sendViewAction(_ action: Action.ViewAction) {
        self.send(.view(action))
    }
    
}
