//
//  ProgramRepository.swift
//  TodayWod
//
//  Created by Davidyoon on 10/15/24.
//

import Foundation



protocol ProgramRepositoryProtocol {
    
    func requestProgram(input: ProgramRequestModel) async throws -> ProgramEntity
    func requestCurrentProgram(input: ProgramRequestModel, id: String) async throws -> ProgramEntity
    func requestOtherRandomProgram(input: OtherProgramRequestModel) async throws -> ProgramEntity

}

final class ProgramRepository: BaseService {

}

extension ProgramRepository: ProgramRepositoryProtocol {
    
    func requestProgram(input: ProgramRequestModel) async throws -> ProgramEntity {
        do {
            let apiRequest = APIRequest()
                .setPath(RequestAPIType.program.url)
                .setQuery(input.dict)

            let result = try await self.request(with: apiRequest, type: ProgramEntity.self)
            DLog.d(result.id)
            return result
        } catch {
            DLog.e("Error: \(error.localizedDescription)")
            throw error
        }
    }

    func requestCurrentProgram(input: ProgramRequestModel, id: String) async throws -> ProgramEntity {
        do {
            let apiRequest = APIRequest()
                .setPath(RequestAPIType.sameProgram(id).url)
                .setQuery(input.dict)

            return try await self.request(with: apiRequest, type: ProgramEntity.self)
        } catch {
            DLog.e("Error: \(error.localizedDescription)")
            throw error
        }
    }

    func requestOtherRandomProgram(input: OtherProgramRequestModel) async throws -> ProgramEntity {
        do {
            let apiRequest = APIRequest()
                .setPath(RequestAPIType.program.url)
                .setQuery(input.dict)

            return try await self.request(with: apiRequest, type: ProgramEntity.self)
        } catch {
            DLog.e("Error: \(error.localizedDescription)")
            throw error
        }
    }

}



