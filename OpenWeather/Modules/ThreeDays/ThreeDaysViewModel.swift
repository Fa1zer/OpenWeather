//
//  ThreeDaysViewModel.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import Foundation

final class ThreeDaysViewModel: NavigationCoordinatorDelegate {
    
//    MARK: - Properties
    private let model: ThreeDaysModel
    let data: DaysWeatherEntity
    
//    MARK: - Init
    init(model: ThreeDaysModel, data: DaysWeatherEntity) {
        self.model = model
        self.data = data
    }
    
//    MARK: - Properties
    private(set) var city: String?
    var coordinator: NavigationCoordinator?
    
//    MARK: - User Defaults
    func getCity() {
        self.city = self.model.getUserDefaults(for: .city)
    }
    
}
