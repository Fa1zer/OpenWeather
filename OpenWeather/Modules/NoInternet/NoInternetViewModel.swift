//
//  NoInternetViewModel.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import Foundation

final class NoInternetViewModel: NavigationCoordinatorDelegate {
    
//    MARK: - Init Properties
    private let model: NoInternetModel
    
    init(model: NoInternetModel) {
        self.model = model
    }
    
//    MARK: - Properties
    var coordinator: NavigationCoordinator?
    
}
