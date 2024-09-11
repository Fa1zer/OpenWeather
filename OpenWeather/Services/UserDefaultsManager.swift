//
//  UserDefaultsManager.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import Foundation

final class UserDefaultsManager {
    
    static func get<T>(for key: UserDefaultsKey) -> T? {
        UserDefaults.standard.value(forKey: key.rawValue) as? T
    }
    
    @discardableResult static func set<T>(_ value: T, for key: UserDefaultsKey) -> T {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        
        return value
    }
    
    static func delete(for key: UserDefaultsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
}
