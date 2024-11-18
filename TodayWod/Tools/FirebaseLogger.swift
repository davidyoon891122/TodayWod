//
//  FLogger.swift
//  TodayWod
//
//  Created by 오지연 on 11/18/24.
//

import Foundation
import FirebaseAnalytics

public enum FLogLevel {
    
    case enter
    case tap
    case event
    
}

extension FLogLevel {
    
    var title: String {
        switch self {
        case .enter:
            return "screen_view"
        case .tap:
            return "button_click"
        case .event:
            return "event"
        }
    }
    
}

public struct FLog {
    
    func enter(_ message: String = "", file: String = #file) {
        log(.enter, message, file)
    }
    
    func tap(_ message: String, file: String = #file) {
        log(.tap, message, file)
    }
    
    func event(_ message: String, file: String = #file) {
        log(.event, message, file)
    }
    
}

private extension FLog {
    
    func log(_ level: FLogLevel, _ message: String, _ file: String) {
        #if RELEASE
        let fileName = file.components(separatedBy: "/").last ?? file
        Analytics.logEvent("\(level.title)", parameters: [
            "file": fileName,
            "message": message
        ])
        #endif
    }
    
}
