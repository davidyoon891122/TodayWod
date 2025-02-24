//
//  Untitled.swift
//  TodayWod
//
//  Created by 오지연 on 2/24/25.
//
import UIKit

enum ApplicationURL {
    
    case youtube(query: String)
    
    var url: URL? {
        URL(string: link)
    }
    
    var webURL: URL? {
        URL(string: webLink)
    }
    
}

private extension ApplicationURL {
    
    var link: String {
        switch self {
        case .youtube(let query):
            let searchQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return "youtube:///results?q=\(searchQuery)"
        }
    }
    
    var webLink: String {
        switch self {
        case .youtube(let query):
            let searchQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return "https://www.youtube.com/results?search_query=\(searchQuery)"
        }
    }
    
}

class ApplicationLoader {
    
    static func open(type: ApplicationURL, completion: ((Bool) -> Void)? = nil) {
        if let url = type.url, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: completion)
        } else {
            guard let webURL = type.webURL else { return }
            UIApplication.shared.open(webURL)
        }
    }

}

