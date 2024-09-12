//
//  MainViewModel.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import Foundation

final class MainViewModel: NavigationCoordinatorDelegate {
        
//    MARK: - Properties
    private let model: MainModel
    let data: MainWeatherEntity
    
//    MARK: - Init
    init(model: MainModel, data: MainWeatherEntity) {
        self.model = model
        self.data = data
    }
    
//    MARK: - Properties
    private(set) var city: String?
    var coordinator: NavigationCoordinator?
    
//    MARK: - Get City
    func getCity() {
        self.city = self.model.getUserDefaults(for: .city)
    }
    
//    MARK: - Routing
    func goToEditCity() {
        self.coordinator?.goToCityEditor()
    }
    
}
