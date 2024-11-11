//
//  OtherProgramRequestModel.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 10/27/24.
//

import Foundation

struct OtherProgramRequestModel: Codable, RequestBodyPresentable {

    let methodType: String
    let level: String
    let gender: String
    let id: String

}
