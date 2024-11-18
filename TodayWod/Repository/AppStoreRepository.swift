//
//  AppStoreRepository.swift
//  TodayWod
//
//  Created by Davidyoon on 11/15/24.
//

import Foundation

protocol AppStoreRepositoryProtocol {
    
    func requestVersion(input: AppStoreResultRequestModel) async throws -> AppInfoEntity
    
}

final class AppStoreRepository {

    private let service: BaseService
    
    init(service: BaseService = BaseService()) {
        self.service = service
    }

}

extension AppStoreRepository: AppStoreRepositoryProtocol {
    
    func requestVersion(input: AppStoreResultRequestModel) async throws -> AppInfoEntity {
        let apiRequest = APIRequest()
            .setPath(RequestAPIType.appStore.url)
            .setQuery(input.dict)
        
        do {
            let result = try await self.service.request(with: apiRequest, type: AppStoreResultInfoEntity.self)
            
            guard let appInfo = result.results.first else {
                throw APIRequestError.emptyData
            }
            
            return appInfo
        } catch {
            DLog.e("Error: \(error.localizedDescription)")
            throw error
        }
    }
    
}
