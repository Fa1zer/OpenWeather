//
//  LoaderView.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import UIKit

final class LoaderViewController: UIViewController {
    
//    MARK: - Init Properties
    private let viewModel: LoaderViewModel
    
    init(viewModel: LoaderViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Properties
    private let dispatchGroup = DispatchGroup()
    
    
//    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getLocation { [ weak self ] in
            self?.dispatchGroup.enter()
            self?.viewModel.getMain {
                self?.dispatchGroup.leave()
            } onError: { _ in
                self?.dispatchGroup.leave()
            }
            self?.dispatchGroup.enter()
            self?.viewModel.getDays {
                self?.dispatchGroup.leave()
            } onError: { _ in
                self?.dispatchGroup.leave()
            }
            self?.dispatchGroup.notify(queue: .main) {
                if self?.viewModel.main != nil, self?.viewModel.days != nil {
                    
                } else {
                    
                }
            }
        } onError: { [ weak self ] _ in
            self?.viewModel.goToCityEditor()
        }
    }
    
    
}
