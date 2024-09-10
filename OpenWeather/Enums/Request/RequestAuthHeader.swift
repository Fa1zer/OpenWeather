//
//  RequestAuthMod.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 10.09.2024.
//

import Foundation

enum RequestAuthHeader {
    case base(email: String, password: String), bearer(value: String)
    
    func construct() -> String? {
        switch self {
        case .base(email: let email, password: let password):
            guard let authString = "\(email):\(password)".data(using: .utf8)?.base64EncodedString() else {
                return nil
            }
            
            return "Basic \(authString)"
        case .bearer(value: let value):
            return "Bearer \(value)"
        }
    }
}
