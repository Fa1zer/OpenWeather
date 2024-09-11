//
//  MainWeatherRequestModel.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import Foundation

struct MainWeatherRequestModel: Encodable {
    let key = WeatherAPI.apiKey
    var q: String
    var aqi = "no"
}
