//
//  CityEditorViewModel.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import Foundation

final class CityEditorViewModel: NavigationCoordinatorDelegate {
    
//    MARK: - Init Properties
    private let model: CityEditorModel
    
    init(model: CityEditorModel) {
        self.model = model
    }
    
//    MARK: - Properties
    var city: String?
    var coordinator: NavigationCoordinator?
    
//    MARK: - User Defaults
    func getCity() {
        self.city = self.model.getUserDefaults(for: .city)
    }
    
    func setCity() {
        guard let city else { return }
        
        self.model.setUserDefaults(city, for: .city)
    }
    
//    MARK: - Routing
    func goToLoader() {
        self.coordinator?.goToLoader()
    }
    
    func getLoader() -> LoaderViewController? {
        self.coordinator?.getLoader()
    }
    
}
