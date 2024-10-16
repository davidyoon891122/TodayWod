//
//  ProgramRepository.swift
//  TodayWod
//
//  Created by Davidyoon on 10/15/24.
//

import Foundation



protocol ProgramRepositoryProtocol {
    
    func requestProgram(input: ProgramRequestModel) async throws -> ProgramEntity
    
}

final class ProgramRepository: BaseService {

}

extension ProgramRepository: ProgramRepositoryProtocol {
    
    func requestProgram(input: ProgramRequestModel) async throws -> ProgramEntity {
        do {
            let apiRequest = APIRequest()
                .setPath("http://158.179.170.39:3000/wod") // TODO: - Base URL 분리
                .setQuery(input.dict)
            
            let entity = try await self.request(with: apiRequest, type: ProgramEntity.self)
            print("Server data: \(entity)")
            
            return entity
        } catch {
            print("Error: \(error.localizedDescription)")
            throw error
        }
    }
    
}



