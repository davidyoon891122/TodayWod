//
//  Logger.swift
//  TodayWod
//
//  Created by Davidyoon on 10/16/24.
//

import Foundation
import OSLog

public enum LogLevel: Int {
    case debug
    case info
    case warning
    case error
    
    var header: String {
        switch self {
        case .debug:
            return "🟢 DEBUG"   // green
        case .info:
            return "🔵 INFO"    // blue
        case .warning:
            return "🟡 WARNING" // yellow
        case .error:
            return "🔴 ERROR"   // red
        }
    }
}

public struct DLog {
    
    private static let logger = Logger()
    
    /// debug
    public static func d(_ message: Any, functionName: String = #function, file: String = #file, line: Int = #line, privacy: OSLogPrivacy = .auto) {
        log(.debug, file, line, functionName, message, privacy)
    }
    
    /// info
    public static func i(_ message: Any, functionName: String = #function, file: String = #file, line: Int = #line, privacy: OSLogPrivacy = .auto) {
        log(.info, file, line, functionName, message, privacy)
    }
    
    /// warning
    public static func w(_ message: Any, functionName: String = #function, file: String = #file, line: Int = #line, privacy: OSLogPrivacy = .auto) {
        log(.warning, file, line, functionName, message, privacy)
    }
    
    /// error
    public static func e(_ message: Any, functionName: String = #function, file: String = #file, line: Int = #line, privacy: OSLogPrivacy = .auto) {
        log(.error, file, line, functionName, message, privacy)
    }
    
    private static func log(_ level: LogLevel, _ file: String, _ line: Int, _ functionName: String, _ message: Any, _ privacy: OSLogPrivacy) {
        
        let message = "\(String.timestamp()) \(level.header) [Main:\(Thread.isMainThread)] [\(file.components(separatedBy: "/").last ?? ""):\(line)] \(String(describing: functionName)) > \(message)"
        
        switch level {
        case .debug:
            logger.debug("\(message, privacy: .auto)")
        case .info:
            logger.info("\(message, privacy: .auto)")
        case .warning:
            logger.warning("\(message, privacy: .auto)")
        case .error:
            logger.error("\(message, privacy: .auto)")
        }
    }
    
}


fileprivate extension String {
    
    static func timestamp() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "y-MM-dd H:mm:ss.SSSS"
        let date = Date()
        return String(format: "%@", formatter.string(from: date))
    }
    
}
