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
    
    init(scheme: URLSchemes, host: URLHosts) {
        var urlComponents = URLComponents()
        
        urlComponents.host = host.rawValue
        urlComponents.scheme = scheme.rawValue
        
        self.baseURL = urlComponents.url ?? .init(fileURLWithPath: .init())
    }
    
    func url(paths: URLPath...) -> URL {
        var url = self.baseURL
        
        for path in paths {
            url = url.appendingPathComponent(path.rawValue)
        }
        
        return url
    }
    
}

//MARK: - URL Weather Contructor
final class URLWeatherContructor {
    
    private let custructor: URLConstructor
    
    init(custructor: URLConstructor) {
        self.custructor = custructor
    }
    
    static let shared = URLWeatherContructor(custructor: .init(scheme: .https, host: .base))
    
    func weather() -> URL {
        self.custructor.url(paths: .version, .currentJson)
    }
    
}
