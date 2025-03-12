//
//  ApplicationLoaderClient.swift
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

import ComposableArchitecture

struct ApplicationLoaderClient {
    
    var open: (ApplicationURL) -> Void
    
}

extension ApplicationLoaderClient: DependencyKey {

    static let liveValue: ApplicationLoaderClient = .init { type in
        if let url = type.url, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            guard let webURL = type.webURL else { return }
            UIApplication.shared.open(webURL)
        }
    }
    
}

extension DependencyValues {
    
    var applicationLoaderClient: ApplicationLoaderClient {
        get { self[ApplicationLoaderClient.self] }
        set { self[ApplicationLoaderClient.self] = newValue }
    }
    
}
