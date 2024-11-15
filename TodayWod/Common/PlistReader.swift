//
//  PlistReader.swift
//  TodayWod
//
//  Created by 오지연 on 11/15/24.
//
import Foundation

enum PlistType: String {
    
    static let plistExtension = "plist"
    
    case admobInfo = "AdmobBanner-Info"
    case googleInfo = "GoogleService-Info"
    
}
                                                          
struct PlistReader {
    
    func getData(type: PlistType, key: String) -> String {
        guard let plistPath = mainBundle.path(forResource: type.rawValue, ofType: PlistType.plistExtension),
              let plistDict = NSDictionary(contentsOfFile: plistPath) else {
            fatalError("\(type.rawValue) Plist <\(key)> not found")
        }
        
        return plistDict[key] as? String ?? ""
    }
    
    func getMainInfo(key: String) -> String {
        guard let value = mainBundle.infoDictionary?[key] as? String else {
            fatalError("Main Info Plist <\(key)> not found")
        }
        
        return value
    }
    
}

private extension PlistReader {
    
    var mainBundle: Bundle {
        Bundle.main
    }
    
}
