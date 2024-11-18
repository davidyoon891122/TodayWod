//
//  VersionInfoModel.swift
//  TodayWod
//
//  Created by Davidyoon on 11/15/24.
//

import Foundation

struct VersionInfoModel: Comparable {
    
    let major: Int
    let minor: Int
    let patch: Int
    
    
    init?(from stringVersion: String) {
        let components = stringVersion.split(separator: ".").compactMap { Int($0) }
        guard components.count == 3 else { return nil }
        self.major = components[safe: 0] ?? 0
        self.minor = components[safe: 1] ?? 0
        self.patch = components[safe: 2] ?? 0
    }
    
    static func < (lhs: VersionInfoModel, rhs: VersionInfoModel) -> Bool {
        if lhs.major != rhs.major { return lhs.major < rhs.major }
        if lhs.minor != rhs.minor { return lhs.minor < rhs.minor }
        return lhs.patch < rhs.patch
    }
    
}
