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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    static let schared = NavigationCoordinator(navigationController: .init())
    
//    MARK: - Start
    func start() -> UINavigationController {
        
        
        return self.navigationController
    }
    
    
    
}
