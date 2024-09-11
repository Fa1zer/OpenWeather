//
//  CityEditorViewController.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import UIKit
import SnapKit

final class CityEditorViewController: UIViewController {
    
//    MARK: - Init Properties
    private let viewModel: CityEditorViewModel
    
    init(viewModel: CityEditorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - UI Properties
    
}
