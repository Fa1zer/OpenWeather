//
//  NoInternetViewController.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import UIKit
import SnapKit

final class NoInternetViewController: UIViewController {
    
//    MARK: - Init Properties
    private let viewModel: NoInternetViewModel
    
    init(viewModel: NoInternetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - UI Properties
    private let imageView: UIImageView = {
        let view = UIImageView(image: .init(systemName: "wifi.exclamationmark"))
        
        view.contentMode = .scaleAspectFill
        view.tintColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        
        view.text = "Нет интернета"
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
//    MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupViews()
        self.setupNavigationBar()
    }
    
//    MARK: - Setup View
    private func setupViews() {
        self.view.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.imageView)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.imageView.snp.makeConstraints { make in
            make.height.width.equalTo(150)
        }
    }
    
//    MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
}
