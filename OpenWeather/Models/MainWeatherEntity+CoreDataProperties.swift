//
//  MainWeatherEntity+CoreDataProperties.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 12.09.2024.
//
//

import Foundation
import CoreData


extension MainWeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainWeatherEntity> {
        return NSFetchRequest<MainWeatherEntity>(entityName: "MainWeatherEntity")
    }

    @NSManaged public var identifyer: UUID?
    @NSManaged public var current: CurrentWeatherEntity
    @NSManaged public var location: LocationWeatherEntity

}

extension MainWeatherEntity : Identifiable {

}
