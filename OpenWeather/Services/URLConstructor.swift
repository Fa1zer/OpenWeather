//
//  URLConstructor.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import Foundation

protocol URLCreator {
    func url(paths: URLPath...) -> URL
}

//  MARK: - URL Constructor
final class URLConstructor: URLCreator {
    
//    MARK: - Properties
    private let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    init?(scheme: URLSchemes, host: URLHosts) {
        var urlComponents = URLComponents()
        
        urlComponents.host = host.rawValue
        urlComponents.scheme = scheme.rawValue
        
        guard let url = urlComponents.url else { return nil }
        
        self.baseURL = url
    }
    
    func url(paths: URLPath...) -> URL {
        var url = self.baseURL
        
        for path in paths {
            url = url.appendingPathComponent(path.rawValue)
        }
        
        return url
    }
    
}
