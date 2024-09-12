//
//  TapBarWithBigItem.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 12.09.2024.
//

import UIKit
import SnapKit

final class TapBarWithBigItem: UITabBarController {
    
//    MARK: - UI Properties
    private lazy var centralItemButton: UIButton = {
        let view = UIButton()
        
        view.setImage(.init(systemName: "house.fill"), for: .normal)
        view.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.3058823529, blue: 0.7803921569, alpha: 1)
        view.tintColor = .white
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 25
        view.layer.zPosition = 1000
        view.addTarget(self, action: #selector(self.didTapBigItem), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
//    MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupViews()
    }
    
//    MARK: - Setup Views
    func setupViews() {
        self.tabBar.itemSpacing = 70
        self.tabBar.tintColor = #colorLiteral(red: 0.1254901961, green: 0.3058823529, blue: 0.7803921569, alpha: 1)
        self.tabBar.addSubview(self.centralItemButton)
        self.centralItemButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalToSuperview().inset(40)
            make.width.height.equalTo(50)
        }
    }
    
//    MARK: - Actions
    @objc private func didTapBigItem() {
        self.selectedIndex = .zero
    }
    
}
