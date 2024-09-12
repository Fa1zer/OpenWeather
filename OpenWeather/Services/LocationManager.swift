//
//  LocationManager.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    
//    MARK: - Properties
    private let manager: CLLocationManager
    private var locationPremitionHandler: ((Bool) -> Void)?
    private var didUpdateLocationHandler: ((Double, Double) -> Void)?
    
//    MARK: - Init
    private init(manager: CLLocationManager) {
        self.manager = manager
    }
    
    static let shared = LocationManager(manager: CLLocationManager())
    
//    MARK: - Request Authorization
    func requestAuthorization(locationPremitionHandler: @escaping (Bool) -> Void) {
        self.manager.delegate = self
        self.locationPremitionHandler = locationPremitionHandler
        self.manager.requestWhenInUseAuthorization()
    }
    
//    MARK: - Get Location
    func getLocation(didUpdateLocationHandler: @escaping (Double, Double) -> Void) {
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.didUpdateLocationHandler = didUpdateLocationHandler
        self.manager.startUpdatingLocation()
    }
    
//    MARK: - Get City Name
    func getCityName(lat: Double, lon: Double, completionHandler: @escaping (String?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(.init(latitude: lat, longitude: lon)) { placemarks, error in
            if let error {
                print("❌ ERROR: \(error.localizedDescription)")
                
                return completionHandler(nil)
            }
            
            guard let city = placemarks?.first?.locality else { return completionHandler(nil) }
            
            completionHandler(city)
        }
    }
    
//    MARK: - Is Authorized
    func isAuthorized() -> Bool {
        [CLAuthorizationStatus.authorizedAlways, .authorizedWhenInUse].contains(self.manager.authorizationStatus)
    }
    
}

//MARK: - Extensions
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.locationPremitionHandler?(
            [CLAuthorizationStatus.authorizedAlways, .authorizedWhenInUse].contains(manager.authorizationStatus)
        )
        self.locationPremitionHandler = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coodinate = manager.location?.coordinate else { return }
        
        self.didUpdateLocationHandler?(coodinate.latitude, coodinate.longitude)
        self.didUpdateLocationHandler = nil
    }
    
}
