//
//  APIRequest.swift
//  TodayWod
//
//  Created by Davidyoon on 10/15/24.
//

import Foundation
import Alamofire

public final class APIRequest {
    private(set) var method: HTTPMethodType = .get
    private(set) var headerFields: [HeaderField] = []
    private(set) var path: String = "" // TODO: - enum path Type으로 변경
    private(set) var query: [String: Any] = [:]
    private(set) var timeout: Int = 60
    private(set) var body: Data? = nil
    
    func setMethod(_ method: HTTPMethodType) -> APIRequest {
        self.method = method
        return self
    }
    
    func setHeaderFields(_ headerFields: [HeaderField]) -> APIRequest {
        self.headerFields = headerFields
        return self
    }
    
    func setPath(_ path: String) -> APIRequest {
        self.path = path
        return self
    }
    
    func setQuery(_ query: [String: Any]) -> APIRequest {
        self.query = query
        return self
    }
    
    func setTimeout(_ timeout: Int) -> APIRequest {
        self.timeout = timeout
        return self
    }
    
    func setBody(_ body: Data) -> APIRequest {
        self.body = body
        return self
    }
    
    func createURLRequest() -> URLRequest? {
        guard var url = URL(string: path), var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        components.queryItems = query.map {
            URLQueryItem(name: $0.key, value: $0.value as? String)
        }
        
        url = components.url!
        
        var request = URLRequest(url: url)
        
        // Set Header fields
        for field in self.headerFields {
            request.addValue(field.value, forHTTPHeaderField: field.name)
        }
        
        request.httpMethod = self.method.rawValue
        request.timeoutInterval = TimeInterval(self.timeout)
        
        if let body = self.body, method != .get {
            request.httpBody = body
        }
        
        return request
    }
    
    
}
