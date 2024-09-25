//
//  AppEnvironment.swift
//  TodayWod
//
//  Created by Davidyoon on 9/25/24.
//

import Foundation

enum AppEnvironment {
    
    enum Keys {
        static let shortVersion = "CFBundleShortVersionString"
        static let version      = "CFBundleVersion"
        static let displayName  = "CFBundleName"
    }
    
    static let version: String? = {
        guard let version = AppEnvironment.infoDictionary[Keys.version] as? String else {
            return nil
        }
        
        return version
    }()
    
    static let shortVersion: String = {
        guard let short = AppEnvironment.infoDictionary[Keys.shortVersion] as? String else {
            fatalError("Plist BundleShortVersion not found")
        }
        
        return short
    }()
    
    static let identifier: String = {
        guard let identifier = mainBundle.bundleIdentifier else {
            fatalError("Plist bundleIdentifier not found")
        }
        
        return identifier
    }()
    
    static let displayName: String = {
        guard let display = AppEnvironment.infoDictionary[Keys.displayName] as? String else {
            fatalError("Plist displayName not found")
        }
        
        return display
    }()
    
}

extension AppEnvironment {
    
    static let mainBundle: Bundle = {
        Bundle.main
    }()
    
    static let infoDictionary: [String: Any] = {
        guard let dict = mainBundle.infoDictionary else {
            fatalError("Plist file not found")
        }
        
        return dict
    }()
    
}
