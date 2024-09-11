//
//  MainViewController.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
//    MARK: - Properties Init
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - UI Properties
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if let humidity = self.viewModel.data?.current?.humidity, humidity > 50 {
            view.image = .init(resource: .rain)
        } else if let cloud = self.viewModel.data?.current?.cloud, cloud > 50 {
            view.image = .init(resource: .clouds)
        } else if let isDay = self.viewModel.data?.current?.isDay, isDay {
            view.image = .init(resource: .sun)
        } else {
            view.image = .init(resource: .moon)
        }
        
        return view
    }()
    
    private lazy var tempLabel: UILabel = {
        let view = UILabel()
        
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if let temp = self.viewModel.data?.current?.temp {
            view.text = "\(temp)°C"
        }
        
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        var text = String()
        
        view.font = .systemFont(ofSize: 16)
        view.textColor = .black
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if let temp = self.viewModel.data?.current?.temp {
            if temp > 15 {
                text = "Температура выше 15 градусов"
            } else if temp >= .zero {
                text = "Температура от 0 до 15 градусов"
            } else {
                text = "Температура меньше 0 градусов"
            }
        }
        
        if let humidity = self.viewModel.data?.current?.humidity {
            if humidity > 50 {
                text += "\n Есть осадки, лучше возьмите зонтик"
            } else {
                text += "\n Нет осадков"
            }
        }
        
        view.text = text
        
        return view
    }()
    
//    MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
        self.setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getCity()
        self.title = self.viewModel.city
    }
    
//    MARK: - Setup Views
    private func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.tempLabel)
        self.view.addSubview(self.descriptionLabel)
        self.imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
            make.width.height.equalTo(100)
        }
        self.tempLabel.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).inset(-15)
            make.centerX.equalToSuperview()
        }
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.tempLabel.snp.bottom).inset(-15)
            make.centerX.equalToSuperview()
        }
    }
    
//    MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        self.tabBarController?.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.navigationController?.navigationBar.backgroundColor = .white
        self.tabBarController?.navigationController?.navigationBar.barTintColor = .white
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: false)
        self.tabBarController?.navigationItem.rightBarButtonItem = .init(title: "Сменить", style: .plain, target: self, action: #selector(self.didTapChange))
    }
    
//    MARK: - Actions
    @objc private func didTapChange() {
        self.viewModel.goToEditCity()
    }
    
}
