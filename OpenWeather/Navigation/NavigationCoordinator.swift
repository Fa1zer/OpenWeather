//
//  NavigationCoordinator.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import UIKit


//MARK: - Navigation Coordinator Delegate
protocol NavigationCoordinatorDelegate {
    var coordinator: NavigationCoordinator? { get set }
}

//MARK: - Navigation Coordinator
final class NavigationCoordinator {
    
//    MARK: - Properties
    private let navigationController: UINavigationController
    private let tabBarController: UITabBarController
    
    init(navigationController: UINavigationController, tabBarController: UITabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    static let schared = NavigationCoordinator(navigationController: .init(), tabBarController: .init())
    
//    MARK: - Start
    func start() -> UINavigationController {
        
        
        return self.navigationController
    }
    
//    MARK: - Main
    func getMain(with data: MainWeatherEntity) -> MainViewController {
        let viewModel = MainViewModel(model: .init(), data: data)
        
        viewModel.coordinator = self
        
        return .init(viewModel: viewModel)
    }
    
}
