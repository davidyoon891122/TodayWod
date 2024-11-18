//
//  APIClient.swift
//  TodayWod
//
//  Created by Davidyoon on 10/15/24.
//

import Foundation
import ComposableArchitecture

struct APIClient {
    var requestProgram: @Sendable (ProgramRequestModel) async throws -> ProgramEntity
    var requestCurrentProgram: @Sendable (ProgramRequestModel, String) async throws -> ProgramEntity
    var requestOtherRandomProgram: @Sendable (OtherProgramRequestModel) async throws -> ProgramEntity
    
    var requestAppVersion: @Sendable (AppStoreResultRequestModel) async throws -> VersionInfoModel
}

extension APIClient: DependencyKey {
    
    static let liveValue = Self(requestProgram: { requestModel in
        let repository = ProgramRepository()
        return try await repository.requestProgram(input: requestModel)
    }, requestCurrentProgram: { requestModel, id in
        let repository = ProgramRepository()
        return try await repository.requestCurrentProgram(input: requestModel, id: id)
    }, requestOtherRandomProgram: { requestModel in
        let repository = ProgramRepository()
        return try await repository.requestOtherRandomProgram(input: requestModel)
    }, requestAppVersion: { requestModel in
        let repository = AppStoreRepository()
        let entity = try await repository.requestVersion(input: requestModel)
        
        guard let model = VersionInfoModel(from: entity.version) else { throw APIRequestError.emptyData }
        return model
    })

}

extension DependencyValues {
    
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
    
}
