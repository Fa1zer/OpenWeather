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
        self.goToLoader()
        
        return self.navigationController
    }
    
//    MARK: - Main
    func getMain(with data: MainWeatherEntity) -> MainViewController {
        let viewModel = MainViewModel(model: .init(), data: data)
        
        viewModel.coordinator = self
        
        return .init(viewModel: viewModel)
    }
    
//    MARK: - Three Days
    func getThreeDyas(with data: DaysWeatherEntity) -> ThreeDaysViewController {
        let viewModel = ThreeDaysViewModel(model: .init(), data: data)
        
        viewModel.coordinator = self
        
        return .init(viewModel: viewModel)
    }
    
//    MARK: - City Editor
    func goToCityEditor() {
        self.navigationController.pushViewController(CityEditorViewController(viewModel: .init(model: .init())), animated: true)
    }
    
//    MARK: - Loader
    func goToLoader() {
        self.navigationController.pushViewController(LoaderViewController(viewModel: .init(model: .init())), animated: true)
    }
    
}
