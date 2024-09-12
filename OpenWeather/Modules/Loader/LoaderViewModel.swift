//
//  LoaderViewModel.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 11.09.2024.
//

import Foundation
import CoreData

final class LoaderViewModel: NavigationCoordinatorDelegate {
    
//    MARK: - Init Properties
    private let model: LoaderModel
    
    init(model: LoaderModel) {
        self.model = model
    }
    
//    MARK: - Properties
    var coordinator: NavigationCoordinator?
    private var city: String?
    private(set) var main: MainWeatherEntity?
    private(set) var days: DaysWeatherEntity?
    private let queue = DispatchQueue(label: "com.atemiy-ziuzin.loader", qos: .utility)
    
//    MARK: - User Defaults
    func getCity() -> String? {
        self.model.getUserDefautls(for: .city)
    }
    
    func setCity() {
        guard let city else { return }
        
        self.model.setUserDefaults(city, for: .city)
    }
    
//    MARK: - Locatioin
    func getLocation(onSuccess: @escaping () -> Void = { }, onError: @escaping (Error) -> Void = { _ in }) {
        if let city = self.getCity() {
            self.city = city
            onSuccess()
        } else {
            if self.model.isAuthorizedLocation() {
                self.model.getLocation { [ weak self ] lat, lon in
                    self?.model.getCity(lat: lat, lon: lon) { city in
                        self?.city = city
                        self?.setCity()
                        onSuccess()
                    } onError: { error in
                        onError(error)
                    }
                }
            } else {
                self.model.requestAuthorization { [ weak self ] status in
                    if status {
                        self?.model.getLocation { lat, lon in
                            self?.model.getCity(lat: lat, lon: lon) { city in
                                self?.city = city
                                self?.setCity()
                                onSuccess()
                            } onError: { error in
                                onError(error)
                            }
                        }
                    } else {
                        onError(RequestError.responseIsEqualToNil)
                    }
                }
            }
        }
    }
    
//    MARK: - Requests
    func getMain(onSuccess: @escaping () -> Void = { }, onError: @escaping (Error) -> Void = { _ in }) {
        guard let city else { return onError(RequestError.encodingFailed) }
        
        self.queue.async(flags: .barrier) { [ weak self ] in
            self?.model.getMain(city: city) { model in
                let context = coreDataMainWether.persistentContainer.newBackgroundContext()
                
                guard let first = NSEntityDescription.entity(
                    forEntityName: .init(describing: MainWeatherEntity.self),
                    in: context
                ),
                let second = NSEntityDescription.entity(
                    forEntityName: .init(describing: CurrentWeatherEntity.self),
                    in: context
                ),
                let third = NSEntityDescription.entity(
                    forEntityName: .init(describing: LocationWeatherEntity.self),
                    in: context
                ) else { return onError(RequestError.statusCodeError(statusCode: 500)) }
                
                let entity = MainWeatherEntity(entity: first, insertInto: context)
                let current = CurrentWeatherEntity(entity: second, insertInto: context)
                let location = LocationWeatherEntity(entity: third, insertInto: context)
                
                entity.identifyer = UUID()
                current.cloud = .init(model.current.cloud)
                current.humidity = .init(model.current.humidity)
                current.isDay = (model.current.isDay != .zero)
                current.temp = model.current.temp
                location.localtime = model.location.localtime
                location.name = model.location.name
                entity.current = current
                entity.location = location
                self?.main = entity
                self?.model.saveMain(entity) { _ in
                    self?.model.getMain { models in
                        self?.main = models.last
                        onSuccess()
                    } onError: { error in
                        onError(error)
                    }
                } onSuccess: {
                    self?.model.getMain { models in
                        self?.main = models.last
                        onSuccess()
                    } onError: { error in
                        onError(error)
                    }
                }
            } onError: { [ weak self ] _ in
                self?.model.getMain { models in
                    self?.main = models.last
                    onSuccess()
                } onError: { error in
                    onError(error)
                }
            }
        }
    }
    
    func getDays(onSuccess: @escaping () -> Void = { }, onError: @escaping (Error) -> Void = { _ in }) {
        guard let city else { return onError(RequestError.encodingFailed) }
        
        self.queue.async(flags: .barrier) { [ weak self ] in
            self?.model.getDays(city: city) { [ weak self ] model in
                let context = coreDataDaysWether.persistentContainer.newBackgroundContext()
                
                guard let first = NSEntityDescription.entity(
                    forEntityName: .init(describing: DaysWeatherEntity.self),
                    in: context
                ),
                let second = NSEntityDescription.entity(
                    forEntityName: .init(describing: ForecastDayWeatherEntity.self),
                    in: context
                ),
                let third = NSEntityDescription.entity(
                    forEntityName: .init(describing: DayWeatherEntity.self),
                    in: context
                ),
                let fourth = NSEntityDescription.entity(
                    forEntityName: .init(describing: LocationWeatherEntity.self),
                    in: context
                ) else { return onError(RequestError.statusCodeError(statusCode: 500)) }
                
                let entity = DaysWeatherEntity(entity: first, insertInto: context)
                let location = LocationWeatherEntity(entity: fourth, insertInto: context)
                
                entity.identifyer = .init()
                location.name = location.name
                location.localtime = location.localtime
                entity.location = location
                
                for day in model.forecast.forecastday {
                    let forecastEntity = ForecastDayWeatherEntity(entity: second, insertInto: context)
                    let dayEntity = DayWeatherEntity(entity: third, insertInto: context)
                    
                    dayEntity.dailyWillItRain = (day.day.dailyWillItRain != .zero)
                    dayEntity.dailyWillItSnow = (day.day.dailyWillItSnow != .zero)
                    dayEntity.maxTemp = day.day.maxTemp
                    dayEntity.minTemp = day.day.minTemp
                    forecastEntity.date = day.date
                    forecastEntity.day = dayEntity
                    entity.addToForecastday(forecastEntity)
                }
                
                self?.model.saveDays(entity) { _ in
                    self?.model.getDays { models in
                        self?.days = models.last
                        onSuccess()
                    } onError: { error in
                        onError(error)
                    }
                } onSuccess: {
                    self?.model.getDays { models in
                        self?.days = models.last
                        onSuccess()
                    } onError: { error in
                        onError(error)
                    }
                }
            } onError: { [ weak self ] _ in
                self?.model.getDays { models in
                    self?.days = models.last
                    onSuccess()
                } onError: { error in
                    onError(error)
                }
            }
        }
    }
    
//    MARK: - Routing
    func goToCityEditor() {
        self.coordinator?.goToCityEditor()
    }
    
    func goToNoInternet() {
        self.coordinator?.goToNoInternet()
    }
    
    func goToTabBar() {
        guard let main, let days else { return }
        
        self.coordinator?.goToTabBar(main: main, days: days)
    }
    
}
