//
//  RequestBodyPresentable.swift
//  TodayWod
//
//  Created by Davidyoon on 10/15/24.
//

import Foundation

protocol RequestBodyPresentable: DictPresentable where Self: Encodable {
    
    var bodyData: Data? { get }
    
}

extension RequestBodyPresentable {
    
    var bodyData: Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try? encoder.encode(self)
    }
    
}

extension RequestBodyPresentable {
    
    var dict: [String : Any] {
        guard let data = self.bodyData else {
            return [:]
        }
        
        var result = [String: Any]()
        do {
            if let data = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                result = data
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return result
    }
    
}
