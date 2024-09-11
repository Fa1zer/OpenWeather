//
//  ForecastWeather.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import Foundation

struct ForecastWeather: Decodable {
    var forecastday: [ForecastDayWeather]
    
    struct ForecastDayWeather: Decodable {
        var date: String
        
        struct DayWeather: Decodable {
            var maxTemp: Double
            var minTemp: Double
            var dailyWillItRain: Int
            var dailyWillItSnow: Int
            
            enum CodingKeys: String, CodingKey {
                case maxTemp = "maxtemp_c"
                case minTemp = "mintemp_c"
                case dailyWillItRain = "daily_will_it_rain"
                case dailyWillItSnow = "daily_will_it_snow"
            }
        }
    }
}
