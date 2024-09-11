//
//  CityEditorModel.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import Foundation

final class CityEditorModel {
    
//    MARK: - User Defaults
    func getUserDefaults(for key: UserDefaultsKey) -> String? {
        UserDefaultsManager.get(for: key)
    }
    
    func setUserDefaults(_ value: String, for key: UserDefaultsKey) {
        UserDefaultsManager.set(value, for: key)
    }
    
}
