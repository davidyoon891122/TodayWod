//
//  HeaderField.swift
//  TodayWod
//
//  Created by Davidyoon on 10/15/24.
//

import Foundation

public struct HeaderField {
    
    var name: String
    var value: String
    
    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
    
}

extension HeaderField {
    
    public static var json: HeaderField {
        HeaderField(name: "Content-Type", value: "application/json")
    }
    
}
