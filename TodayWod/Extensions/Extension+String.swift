//
//  Extension+String.swift
//  TodayWod
//
//  Created by 오지연 on 9/28/24.
//

import Foundation

enum DateFormat: String {
    
    case dash = "yyyy-MM-dd"
    
}

extension String {

    var toInt: Int {
        Int(self) ?? 0
    }
    
    func toDate(_ type: DateFormat = .dash) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.rawValue

        return dateFormatter.date(from: self)
    }
    
    func isValidNickName() -> Bool {
        let regex = "^[a-zA-Z가-힣0-9]{2,10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

        return predicate.evaluate(with: self)
    }
    
    func filteredNickName() -> String {
        let regex = "^[a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ\\u1100-\\u1112\\u318D\\u119E\\u11A2\\u2022\\u2025\\u00B7\\uFE55\\s]*$"
                        
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

import SwiftUI
// Convert String to Image
extension String {
   var toSwiftUIImage: Image {
       guard let asset = {
           switch self {
           case "upperBodyEndurance1M": return Images.upperBodyEndurance1M
           case "upperBodyEndurance1W": return Images.upperBodyEndurance1W
           case "upperBodyEndurance2M": return Images.upperBodyEndurance2M
           case "upperBodyEndurance2W": return Images.upperBodyEndurance2W
           case "upperBodyStrength1M": return Images.upperBodyStrength1M
           case "upperBodyStrength1W": return Images.upperBodyStrength1W
           case "upperBodyStrength2M": return Images.upperBodyStrength2M
           case "upperBodyStrength2W": return Images.upperBodyStrength2W
           case "lowerBodyEndurance1M": return Images.lowerBodyEndurance1M
           case "lowerBodyEndurance1W": return Images.lowerBodyEndurance1W
           case "lowerBodyEndurance2M": return Images.lowerBodyEndurance2M
           case "lowerBodyEndurance2W": return Images.lowerBodyEndurance2W
           case "lowerBodyStrength1M": return Images.lowerBodyStrength1M
           case "lowerBodyStrength1W": return Images.lowerBodyStrength1W
           case "lowerBodyStrength2M": return Images.lowerBodyStrength2M
           case "lowerBodyStrength2W": return Images.lowerBodyStrength2W
           case "coreStrength1M": return Images.coreStrength1M
           case "coreStrength1W": return Images.coreStrength1W
           case "coreStrength2M": return Images.coreStrength2M
           case "coreStrength2W": return Images.coreStrength2W
           case "fullBodyConditioning1M": return Images.fullBodyConditioning1M
           case "fullBodyConditioning1W": return Images.fullBodyConditioning1W
           case "fullBodyConditioning2M": return Images.fullBodyConditioning2M
           case "fullBodyConditioning2W": return Images.fullBodyConditioning2W
           default: return nil
           }
       }() else {
           return Image(asset: Images.upperBodyEndurance1M)
       }

       return Image(asset: asset)
   }
}
