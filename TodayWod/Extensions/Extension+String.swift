//
//  Extension+String.swift
//  TodayWod
//
//  Created by 오지연 on 9/28/24.
//

import Foundation

extension String {
    
    var toInt: Int {
        Int(self) ?? 0
    }
    
    func isValidNickName() -> Bool {
        let regex = "^[a-zA-Z가-힣0-9]{2,10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

        return predicate.evaluate(with: self)
    }
    
    func nickNameFilter() -> String {
        let regex = "^[a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ]*$"
                        
        if let _ = self.range(of: regex, options: .regularExpression) {
            return "\(self.prefix(10))"
        } else {
            return String(self.prefix(self.count - 1))
        }
    }
    
    func isValidHeight() -> Bool {
        let regex = "^[0-9]{3}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

        return predicate.evaluate(with: self)
    }
    
    func heightFilter() -> String {
        let regex = "^[0-9]*$"
        
        if let _ = self.range(of: regex, options: .regularExpression) {
            print("pass")
            return "\(self.prefix(3))"
        } else {
            print("Can't pass")
            return String(self.prefix(self.count - 1))
        }
        
    }
    
}
