//
//  ForecastRequestModel.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import Foundation

struct DaysRequestModel: Encodable {
    let key = WeatherAPI.apiKey
    var q: String
    var days = 3
    var aqi = "no"
    var alerts = "no"
}
