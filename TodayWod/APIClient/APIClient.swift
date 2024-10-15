//
//  APIClient.swift
//  TodayWod
//
//  Created by Davidyoon on 10/15/24.
//

import Foundation
import ComposableArchitecture

struct APIClient {
    var requestProgram: @Sendable (ProgramRequestModel) async -> Void
}

extension APIClient: DependencyKey {
    
    static let liveValue = Self(requestProgram: { requestModel in
        let repository = ProgramRepository()
        await repository.requestProgram(input: requestModel)
    })
    
}

extension DependencyValues {
    
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
    
}
