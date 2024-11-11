//
//  ProgramInputModel.swift
//  TodayWod
//
//  Created by Davidyoon on 10/15/24.
//

import Foundation

struct ProgramRequestModel: Codable, RequestBodyPresentable {
    
    let methodType: String
    let level: String
    let gender: String
    
}
