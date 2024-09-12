//
//  LocationWeatherEntity+CoreDataProperties.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 12.09.2024.
//
//

import Foundation
import CoreData


extension LocationWeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationWeatherEntity> {
        return NSFetchRequest<LocationWeatherEntity>(entityName: "LocationWeatherEntity")
    }

    @NSManaged public var localtime: String
    @NSManaged public var name: String

}

extension LocationWeatherEntity : Identifiable {

}
