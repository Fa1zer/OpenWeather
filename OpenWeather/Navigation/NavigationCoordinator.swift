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
    
    static let schared = NavigationCoordinator(navigationController: .init(), tabBarController: TapBarWithBigItem())
    
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
        
        let view = ThreeDaysViewController(viewModel: viewModel)
        
        view.tabBarItem = .init(title: nil, image: .init(systemName: "list.dash.header.rectangle"), selectedImage: .init(systemName: "list.dash.header.rectangle"))
        
        return view
    }
    
//    MARK: - City Editor
    func goToCityEditor() {
        let viewModel = CityEditorViewModel(model: .init())
        
        viewModel.coordinator = self
        self.navigationController.pushViewController(CityEditorViewController(viewModel: viewModel), animated: true)
    }
    
//    MARK: - Loader
    func goToLoader() {
        let viewModel = LoaderViewModel(model: .init())
        
        viewModel.coordinator = self
        self.navigationController.pushViewController(LoaderViewController(viewModel: viewModel), animated: true)
    }
    
//    MARK: - No Internet
    func goToNoInternet() {
        let viewModel = NoInternetViewModel(model: .init())
        
        viewModel.coordinator = self
        self.navigationController.pushViewController(NoInternetViewController(viewModel: viewModel), animated: true)
    }
    
//    MARK: - Go To Tab Bar
    func goToTabBar(main: MainWeatherEntity, days: DaysWeatherEntity) {
        self.tabBarController.viewControllers = [self.getMain(with: main), self.getThreeDyas(with: days)]
        self.navigationController.pushViewController(self.tabBarController, animated: true)
    }
    
}
