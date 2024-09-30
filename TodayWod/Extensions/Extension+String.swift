//
//  Extension+String.swift
//  TodayWod
//
//  Created by Davidyoon on 9/30/24.
//

import Foundation

extension String {
    
    func isValidNickName() -> Bool {
        let regex = "^[a-zA-Z가-힣0-9]{2,10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

        return predicate.evaluate(with: self)
    }
    
}
