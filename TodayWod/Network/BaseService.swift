//
//  BaseService.swift
//  TodayWod
//
//  Created by Davidyoon on 10/15/24.
//

import Foundation
import Alamofire

class BaseService {
    
    var jsonHeader: [HeaderField] {
        [HeaderField.json]
    }
    
}

extension BaseService {
    
    func request<T: Codable>(with apiRequest: APIRequest,
                             type: T.Type) async throws -> T {
        guard let urlRequest = apiRequest.createURLRequest() else {
            throw APIRequestError.createRequestError
        }
        
        let request = AF.request(urlRequest)
        let dataTask = request.serializingData()
        
        let response = await dataTask.response
        
        guard let data = await dataTask.response.data else {
            throw APIRequestError.emptyData
        }
        
        if let statusCode = response.response?.statusCode {
            switch statusCode {
            case 200..<300:
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    return decodedData
                } catch let decodingError as DecodingError {
                    logDecodingError(decodingError, data: data)
                    throw APIRequestError.decodingFailed
                } catch {
                    throw error
                }
            case 400..<500:
                throw ClientError.invalidRequest
            case 500..<600:
                throw ServerError.unknownServerError
            default:
                throw APIRequestError.unknownError(statusCode: statusCode)
            }
        } else {
            throw NetworkError.noResponse
        }
    }
    
}

private extension BaseService {
    func logDecodingError(_ error: DecodingError, data: Data) {
        print("DecodingError occurred: \(error)")
        print("-----------------------------------------------------------------------------")
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Response JSON: \(jsonString)")
        }
        
        switch error {
        case .typeMismatch(let type, let context):
            print("Type mismatch for type \(type) in context: \(context.debugDescription)")
        case .valueNotFound(let type, let context):
            print("Value not found for type \(type) in context: \(context.debugDescription)")
        case .keyNotFound(let key, let context):
            print("Key '\(key.stringValue)' not found: \(context.debugDescription)")
            print("Coding Path: \(context.codingPath)")
        case .dataCorrupted(let context):
            print("Data corrupted: \(context.debugDescription)")
        @unknown default:
            print("Unknown decoding error: \(error.localizedDescription)")
        }
        print("-----------------------------------------------------------------------------")
        
    }
    
}

enum NetworkError: Error {
    case noResponse
    case connectionFailed
}

enum APIRequestError: Error {
    case createRequestError
    case unknownError(statusCode: Int)
    case decodingFailed
    case emptyData
}

enum ClientError: Error {
    case invalidRequest
}

enum ServerError: Error {
    case unknownServerError
}

