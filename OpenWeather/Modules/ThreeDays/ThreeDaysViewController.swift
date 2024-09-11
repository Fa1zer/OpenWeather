//
//  ThreeDaysViewController.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import UIKit
import SnapKit

final class ThreeDaysViewController: UIViewController {
    
//    MARK: - Init Properties
    private let viewModel: ThreeDaysViewModel
    
    init(viewModel: ThreeDaysViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - UI Properties
    private lazy var tableView: UITableView = {
        let view = UITableView()
        
        view.backgroundColor = .white
        view.dataSource = self
        view.delegate = self
        view.register(DayWetherTableViewCell.self, forCellReuseIdentifier: DayWetherTableViewCell.id)
        view.translatesAutoresizingMaskIntoConstraints = false
        
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
    
//    MARK: - Setup View
    private func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.height.equalTo(self.view.safeAreaLayoutGuide)
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
        
    }
    
}

//MARK: - Extensions
extension ThreeDaysViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.data.forecastday.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DayWetherTableViewCell.id,
            for: indexPath
        ) as? DayWetherTableViewCell else { return .init() }
        
        cell.wether = Array(self.viewModel.data.forecastday)[indexPath.row]
        
        return cell
    }
    
}

extension ThreeDaysViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
