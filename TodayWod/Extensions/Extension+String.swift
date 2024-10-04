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

    var charWrapping: String {
        return self.split(separator: "").joined(separator: "\u{200B}")
    }
    
}
