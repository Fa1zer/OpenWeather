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
    
    
//    MARK: - UI Properties
    private let imageView: UIImageView = {
        let view = UIImageView(image: .init(resource: .mainIcon))
        
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        
        view.color = .white
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
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
                    self?.viewModel.goToTabBar()
                } else {
                    self?.viewModel.goToNoInternet()
                }
            }
        } onError: { [ weak self ] _ in
            self?.viewModel.goToCityEditor()
        }
    }
    
//    MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupViews()
        self.setupNavigationBar()
    }
    
//    MARK: - Setup View
    func setupViews() {
        self.view.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.3058823529, blue: 0.7803921569, alpha: 1)
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.activityIndicatorView)
        self.imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(self.view.bounds.width - 40)
        }
        self.activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
        }
    }
    
//    MARK: - Setup Navigation Bar
    func setupNavigationBar() {
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
}
