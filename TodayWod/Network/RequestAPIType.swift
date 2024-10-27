//
//  RequestAPIType.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 10/27/24.
//

import Foundation

protocol APITypePresentable {

    var prefixPath: String { get }
    var path: String { get }
    var url: String { get }

    var base: String { get }

}

extension APITypePresentable {

    var url: String {
        return "\(self.base)\(self.prefixPath)/\(self.path)"
    }

}

enum RequestAPIType {

    case program
    case sameProgram(String)

}

extension RequestAPIType: APITypePresentable {

    var prefixPath: String {
        switch self {
        default:
            ""
        }
    }
    
    var path: String {
        switch self {
        case .program:
            "wod"
        case .sameProgram(let id):
            "wod/\(id)"
        }
    }
    
    var base: String {
        EnvironmentConfiguration.environment.baseURL
    }

}
