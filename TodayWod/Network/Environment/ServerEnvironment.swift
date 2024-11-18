//
//  Environment.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 10/27/24.
//

import Foundation

protocol ServerEnvironment {

    var baseURL: String { get }

}

struct TOWEnvironment: ServerEnvironment {

    let baseURL: String

    init(baseURL: String) {
        self.baseURL = baseURL
    }

}

extension TOWEnvironment {

    static let real: Self = .init(baseURL: "http://158.179.170.39:3000")
    static let appStore: Self = .init(baseURL: "https://itunes.apple.com")

}
