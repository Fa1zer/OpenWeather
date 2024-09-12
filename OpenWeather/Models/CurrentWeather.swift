//
//  CurrentWeather.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import Foundation

struct CurrentWeather: Decodable {
    var temp: Double
    var isDay: Int
    var cloud: Int
    var humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp_c"
        case isDay = "is_day"
        case cloud, humidity
    }
}
