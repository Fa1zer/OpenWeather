//
//  ThreeDaysModel.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import Foundation

final class ThreeDaysModel {
    
//    MARK: - User Defaults
    func getUserDefaults(for key: UserDefaultsKey) -> String? {
        UserDefaultsManager.get(for: key)
    }
    
}
