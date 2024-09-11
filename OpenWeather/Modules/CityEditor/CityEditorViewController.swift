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
    private lazy var textField: UITextField = {
        let view = UITextField()
        
        view.backgroundColor = .clear
        view.textColor = .black
        view.placeholder = "Город"
        view.font = .systemFont(ofSize: 16)
        view.addTarget(self, action: #selector(self.didSetCityText), for: .editingChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let view = UIButton()
        
        view.setImage(.init(systemName: "chevron.right"), for: .normal)
        view.backgroundColor = .systemBlue
        view.addTarget(self, action: #selector(self.didTapNext), for: .touchUpInside)
        view.imageView?.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
//    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.setCity()
        self.textField.text = self.viewModel.city
        self.nextButton.isEnabled = (self.viewModel.city?.isEmpty ?? true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
        self.setupViews()
    }
    
//    MARK: - Setup View
    private func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.textField)
        self.view.addSubview(self.nextButton)
        self.textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalTo(self.nextButton.snp.left).inset(-15)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
//    MARK: - Actions
    @objc private func didSetCityText() {
        self.viewModel.city = self.textField.text
        self.nextButton.isEnabled = (self.viewModel.city?.isEmpty ?? true)
    }
    
    @objc private func didTapNext() {
        self.viewModel.setCity()
        self.viewModel.goToLoader()
    }
    
}
