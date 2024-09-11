//
//  LoaderModel.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import Foundation

final class LoaderModel {
    
//    MARK: - Request
    func getMain(city: String, onSuccess: @escaping (MainWeather) -> Void, onError: @escaping (Error) -> Void) {
        WeatherRequestManager.getMain(city: city) { model, error in
            if let error {
                onError(error)
            } else if let model {
                onSuccess(model)
            } else {
                onError(RequestError.dataIsEqualToNil)
            }
        }
    }
    
    func getDays(city: String, onSuccess: @escaping (DaysWeather) -> Void, onError: @escaping (Error) -> Void) {
        WeatherRequestManager.getDays(city: city) { model, error in
            if let error {
                onError(error)
            } else if let model {
                onSuccess(model)
            } else {
                onError(RequestError.dataIsEqualToNil)
            }
        }
    }
    
//    MARK: - Core Data
    func saveMain(_ model: MainWeatherEntity, onError: @escaping (Error) -> Void, onSuccess: @escaping () -> Void) {
        coreDataMainWether.save(model) { error in
            guard let error else { return onSuccess() }
            
            onError(error)
        }
    }
    
    func saveDays(_ model: DaysWeatherEntity, onError: @escaping (Error) -> Void, onSuccess: @escaping () -> Void) {
        coreDataDaysWether.save(model) { error in
            guard let error else { return onSuccess() }
            
            onError(error)
        }
    }
    
    func getMain(onSuccess: @escaping ([MainWeatherEntity]) -> Void, onError: @escaping (Error) -> Void) {
        coreDataMainWether.all { models, error in
            guard let error else { return onSuccess(models) }
            
            onError(error)
        }
    }
    
    func getDays(onSuccess: @escaping ([DaysWeatherEntity]) -> Void, onError: @escaping (Error) -> Void) {
        coreDataDaysWether.all { models, error in
            guard let error else { return onSuccess(models) }
            
            onError(error)
        }
    }
    
//    MARK: - Location Manager
    func isAuthorizedLocation() -> Bool {
        LocationManager.shared.isAuthorized()
    }
    
    func requestAuthorization(completionHandler: @escaping (Bool) -> Void) {
        LocationManager.shared.requestAuthorization(locationPremitionHandler: completionHandler)
    }
    
    func getLocation(completionHandler: @escaping (Double, Double) -> Void) {
        LocationManager.shared.getLocation(didUpdateLocationHandler: completionHandler)
    }
    
    func getCity(lat: Double, lon: Double, onSuccess: @escaping (String) -> Void, onError: @escaping (Error) -> Void) {
        LocationManager.shared.getCityName(lat: lat, lon: lon) { str in
            guard let str else { return onError(RequestError.dataIsEqualToNil) }
            
            onSuccess(str)
        }
    }
    
//    MARK: - User Defaults
    func getUserDefautls(for key: UserDefaultsKey) -> String? {
        UserDefaultsManager.get(for: key)
    }
    
    func setUserDefaults(_ value: String, for key: UserDefaultsKey) {
        UserDefaultsManager.set(value, for: key)
    }
    
}
