//
//  DayWetherTableViewCell.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import UIKit
import SnapKit

class DayWetherTableViewCell: UITableViewCell {
    
//    MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Properties
    static let id = String(describing: DayWetherTableViewCell.self)
    var wether: ForecastDayWeatherEntity? {
        didSet {
            guard let wether, let day = wether.day else { return }
            if day.dailyWillItRain || day.dailyWillItSnow {
                self.iconImageView.image = .init(resource: .rain)
            } else {
                self.iconImageView.image = .init(resource: .sun)
            }
            
            self.timeLabel.text = (wether.date ?? .init()).suffix(5).replacingOccurrences(of: "-", with: ".")
            self.minValueLabel.text = "\(day.minTemp)°C"
            self.maxValueLabel.text = "\(day.maxTemp)°C"
        }
    }
    
//    MARK: - UI Properties
    private let iconImageView: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let timeLabel: UILabel = {
        let view = UILabel()
        
        view.font = .boldSystemFont(ofSize: 16)
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let minStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let maxStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let minTitleLabel: UILabel = {
        let view = UILabel()
        
        view.text = "Мин"
        view.font = .boldSystemFont(ofSize: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let maxTitleLabel: UILabel = {
        let view = UILabel()
        
        view.text = "Макс"
        view.font = .boldSystemFont(ofSize: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let minValueLabel: UILabel = {
        let view = UILabel()
        
        view.font = .systemFont(ofSize: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let maxValueLabel: UILabel = {
        let view = UILabel()
        
        view.font = .systemFont(ofSize: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
//    MARK: - Setup Views
    private func setupViews() {
        self.backgroundColor = .white
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.iconImageView)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.minStackView)
        self.contentView.addSubview(self.maxStackView)
        self.minStackView.addArrangedSubview(self.minTitleLabel)
        self.minStackView.addArrangedSubview(self.minValueLabel)
        self.maxStackView.addArrangedSubview(self.maxTitleLabel)
        self.maxStackView.addArrangedSubview(self.maxValueLabel)
        self.iconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.top.leading.equalToSuperview().inset(15)
        }
        self.timeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalTo(self.iconImageView)
        }
        self.minStackView.snp.makeConstraints { make in
            make.top.equalTo(self.iconImageView.snp.bottom).inset(-10)
            make.centerX.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalToSuperview().inset(15)
        }
        self.maxStackView.snp.makeConstraints { make in
            make.top.equalTo(self.iconImageView.snp.bottom).inset(-10)
            make.centerX.equalToSuperview().multipliedBy(1.5)
            make.bottom.equalToSuperview().inset(15)
        }
    }

}
