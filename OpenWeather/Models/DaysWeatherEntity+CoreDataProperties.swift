//
//  DaysWeatherEntity+CoreDataProperties.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//
//

import Foundation
import CoreData


extension DaysWeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DaysWeatherEntity> {
        return NSFetchRequest<DaysWeatherEntity>(entityName: "DaysWeatherEntity")
    }

    @NSManaged public var forecastday: Set<ForecastDayWeatherEntity>
    @NSManaged public var location: LocationWeatherEntity
    @NSManaged public var identifyer: UUID
}

// MARK: Generated accessors for forecastday
extension DaysWeatherEntity {

    @objc(addForecastdayObject:)
    @NSManaged public func addToForecastday(_ value: ForecastDayWeatherEntity)

    @objc(removeForecastdayObject:)
    @NSManaged public func removeFromForecastday(_ value: ForecastDayWeatherEntity)

    @objc(addForecastday:)
    @NSManaged public func addToForecastday(_ values: Set<ForecastDayWeatherEntity>)

    @objc(removeForecastday:)
    @NSManaged public func removeFromForecastday(_ values: Set<ForecastDayWeatherEntity>)

}

extension DaysWeatherEntity : Identifiable {

}
