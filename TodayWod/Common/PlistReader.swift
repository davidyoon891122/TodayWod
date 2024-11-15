//
//  PlistReader.swift
//  TodayWod
//
//  Created by D프로젝트노드_오지연 on 11/15/24.
//
import Foundation

enum PlistType: String {
    
    static let plistExtension = "plist"
    
    case admobInfo = "AdmobBanner-Info"
    case googleInfo = "GoogleService-Info"
    case mainInfo = "info"
    
}
                                                          
struct PlistReader {
    
    func getData(type: PlistType, key: String) -> String? {
        guard let plistPath = Bundle.main.path(forResource: type.rawValue, ofType: PlistType.plistExtension),
              let plistDict = NSDictionary(contentsOfFile: plistPath) else {
            return nil
        }
        return plistDict[key] as? String
    }
    
}
