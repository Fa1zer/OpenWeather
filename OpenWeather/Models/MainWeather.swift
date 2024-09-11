//
//  MainWeather.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import Foundation

struct MainWeather: Decodable {
    var location: LocationWeather
    var current: CurrentWeather
}
