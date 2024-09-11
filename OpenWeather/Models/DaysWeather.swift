//
//  DaysWeather.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import Foundation

struct DaysWeather: Decodable {
    var location: LocationWeather
    var forecast: ForecastWeather
}
