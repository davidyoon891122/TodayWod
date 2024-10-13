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
    
    var toDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"

        return dateFormatter.date(from: self)
    }
    
    func isValidNickName() -> Bool {
        let regex = "^[a-zA-Z가-힣0-9]{2,10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

        return predicate.evaluate(with: self)
    }
    
    func filteredNickName() -> String {
        let regex = "^[a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ]*$"
                        
        if let _ = self.range(of: regex, options: .regularExpression) {
            return "\(self.prefix(Constants.nickNameMaxLength))"
        } else {
            return String(self.prefix(self.count - 1))
        }
    }
    
    func isValidHeightWeight() -> Bool {
        let regex = "^[0-9]{2,3}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

        return predicate.evaluate(with: self) && Int(self) ?? 0 > 0
    }
    
    func filteredHeightWeight() -> String {
        let regex = "^[0-9]*$"
        
        if let _ = self.range(of: regex, options: .regularExpression) {
            return "\(self.prefix(Constants.weightHeightMaxLength))"
        } else {
            return String(self.prefix(self.count - 1))
		}
    }

	var charWrapping: String {
		return self.split(separator: "").joined(separator: "\u{200B}")
	}

}

private extension String {

    enum Constants {
        static let nickNameMaxLength: Int = 10
        static let weightHeightMaxLength: Int = 3
    }

}
