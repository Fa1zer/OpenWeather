//
//  RequestManager.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 10.09.2024.
//

import Foundation

final class RequestManager {
    
    // MARK: Request 1
    static func request<T : Decodable>(
        method: RequestMethod,
        authMod: RequestAuthHeader? = nil,
        url: URL,
        completionHandler: @escaping (T?, Error?) -> Void
    ) {
        var req = URLRequest(url: url)
        
        req.httpMethod = method.rawValue
        req.setValue(RequestHeader.applicationJson.rawValue, forHTTPHeaderField: RequestHeader.contentType.rawValue)
        
        if let authMod {
            req.setValue(authMod.construct(), forHTTPHeaderField: RequestHeader.authorization.rawValue)
        }
        
        URLSession.shared.dataTask(with: req) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                
                return
            }
            
            if let httpURLResponse = response as? HTTPURLResponse {
                guard httpURLResponse.statusCode == 200 else {
                    print("❌ Error: status code is equal to \(httpURLResponse.statusCode)")
                    
                    DispatchQueue.main.async {
                        completionHandler(nil, RequestError.statusCodeError(statusCode: httpURLResponse.statusCode))
                    }
                    
                    return
                }
                
                guard let data else {
                    print("❌ Error: data is equal to nil.")
                    
                    DispatchQueue.main.async {
                        completionHandler(nil, RequestError.dataIsEqualToNil)
                    }
                    
                    return
                }
                
                guard let model = try? JSONDecoder().decode(T.self, from: data) else {
                    print("❌ Error: decoding failed.")
                    
                    DispatchQueue.main.async {
                        completionHandler(nil, RequestError.decodingFailed)
                    }
                    
                    return
                }
                
                DispatchQueue.main.async {
                    completionHandler(model, nil)
                }
            } else {
                print("❌ Error: response is equal to nil.")
                
                DispatchQueue.main.async {
                    completionHandler(nil, RequestError.responseIsEqualToNil)
                }
                
                return
            }
        }
        .resume()
    }
    
    // MARK: Request 2
    static func request<T1 : Encodable, T2 : Decodable>(
        sendModel: T1,
        method: RequestMethod,
        authMod: RequestAuthHeader? = nil,
        url: URL,
        completionHandler: @escaping (T2?, Error?) -> Void
    ) {
        var req = URLRequest(url: url)
        
        req.httpMethod = method.rawValue
        req.setValue(RequestHeader.applicationJson.rawValue, forHTTPHeaderField: RequestHeader.contentType.rawValue)
        
        if let authMod {
            req.setValue(authMod.construct(), forHTTPHeaderField: RequestHeader.authorization.rawValue)
        }
        
        if let sendData = try? JSONEncoder().encode(sendModel) {
            req.setValue(.init(format: "%lu", UInt(sendData.count)), forHTTPHeaderField: RequestHeader.contentLenght.rawValue)
            req.httpBody = sendData
            
            URLSession.shared.dataTask(with: req) { data, response, error in
                if let error = error {
                    print("❌ Error: \(error.localizedDescription)")
                    
                    DispatchQueue.main.async {
                        completionHandler(nil, error)
                    }
                    
                    return
                }
                
                if let httpURLResponse = response as? HTTPURLResponse {
                    guard httpURLResponse.statusCode == 200 else {
                        print("❌ Error: status code is equal to \(httpURLResponse.statusCode)")
                        
                        DispatchQueue.main.async {
                            completionHandler(nil, RequestError.statusCodeError(statusCode:httpURLResponse.statusCode))
                        }
                        
                        return
                    }
                    
                    guard let data else {
                        print("❌ Error: data is equal to nil.")
                        
                        DispatchQueue.main.async {
                            completionHandler(nil, RequestError.dataIsEqualToNil)
                        }
                        
                        return
                    }
                    
                    guard let model = try? JSONDecoder().decode(T2.self, from: data) else {
                        print("❌ Error: decoding failed.")
                        
                        DispatchQueue.main.async {
                            completionHandler(nil, RequestError.decodingFailed)
                        }
                        
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completionHandler(model, nil)
                    }
                } else {
                    print("❌ Error: response is equal to nil.")
                    
                    DispatchQueue.main.async {
                        completionHandler(nil, RequestError.responseIsEqualToNil)
                    }
                    
                    return
                }
            }
            .resume()
        } else {
            print("❌ Error: encoding failed.")
            
            completionHandler(nil, RequestError.encodingFailed)
            
            return
        }
    }
    
    // MARK: Request 3
    static func request<T : Encodable>(
        model: T,
        method: RequestMethod,
        authMod: RequestAuthHeader? = nil,
        url: URL,
        completionHandler: @escaping (Error?) -> Void
    ) {
        var req = URLRequest(url: url)
        
        req.httpMethod = method.rawValue
        req.setValue(RequestHeader.applicationJson.rawValue, forHTTPHeaderField: RequestHeader.contentType.rawValue)
        
        if let authMod {
            req.setValue(authMod.construct(), forHTTPHeaderField: RequestHeader.authorization.rawValue)
        }
        
        if let data = try? JSONEncoder().encode(model) {
            req.setValue(.init(format: "%lu", UInt(data.count)), forHTTPHeaderField: RequestHeader.contentLenght.rawValue)
            req.httpBody = data
            
            URLSession.shared.dataTask(with: req) { _, response, error in
                if let error = error {
                    print("❌ Error: \(error.localizedDescription)")
                    
                    DispatchQueue.main.async {
                        completionHandler(error)
                    }
                    
                    return
                }
                
                if let httpURLResponse = response as? HTTPURLResponse {
                    guard httpURLResponse.statusCode == 200 else {
                        print("❌ Error: status code is equal to \(httpURLResponse.statusCode)")
                        
                        DispatchQueue.main.async {
                            completionHandler(RequestError.statusCodeError(statusCode:
                                                                                httpURLResponse.statusCode))
                        }
                        return
                    }
                    
                        DispatchQueue.main.async {
                            completionHandler(nil)
                        }
                    
                } else {
                    print("❌ Error: response is equal to nil.")
                    
                    DispatchQueue.main.async {
                        completionHandler(RequestError.responseIsEqualToNil)
                    }
                    
                    return
                }
            }
            .resume()
        } else {
            print("❌ Error: encoding failed.")
            
            completionHandler(RequestError.encodingFailed)
            
            return
        }
    }
    
    // MARK: Request 4
    static func request(
        method: RequestMethod,
        authMod: RequestAuthHeader? = nil,
        url: URL,
        completionHandler: @escaping (Error?) -> Void
    ) {
        var req = URLRequest(url: url)
        
        req.httpMethod = method.rawValue
        req.setValue(RequestHeader.applicationJson.rawValue, forHTTPHeaderField: RequestHeader.contentType.rawValue)
        
        if let authMod {
            req.setValue(authMod.construct(), forHTTPHeaderField: RequestHeader.authorization.rawValue)
        }
        
        URLSession.shared.dataTask(with: req) { _, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                
                DispatchQueue.main.async {
                    completionHandler(error)
                }
                
                return
            }
            
            if let httpURLResponse = response as? HTTPURLResponse {
                guard httpURLResponse.statusCode == 200 else {
                    print("❌ Error: status code is equal to \(httpURLResponse.statusCode)")
                    
                    DispatchQueue.main.async {
                        completionHandler(RequestError.statusCodeError(statusCode: httpURLResponse.statusCode))
                    }
                    
                    return
                }
                
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
                
            } else {
                print("❌ Error: response is equal to nil.")
                
                DispatchQueue.main.async {
                    completionHandler(RequestError.responseIsEqualToNil)
                }
                
                return
            }
        }
        .resume()
    }
    
}

final class WeatherRequestManager {
    
    static func getMain(city: String, completionHandler: @escaping (MainWeather?, Error?) -> Void) {
        var url = URLComponents(string: URLWeatherContructor.shared.weather().absoluteString)
        
        url?.queryItems = [.init(name: "key", value: WeatherAPI.apiKey), .init(name: "q", value: city), .init(name: "aqi", value: "no")]
        
        RequestManager.request(
            method: .GET,
            url: url?.url ?? .init(fileURLWithPath: .init()),
            completionHandler: completionHandler
        )
    }
    
    static func getDays(city: String, completionHandler: @escaping (DaysWeather?, Error?) -> Void) {
        var url = URLComponents(string: URLWeatherContructor.shared.forecast().absoluteString)
        
        url?.queryItems = [
            .init(name: "key", value: WeatherAPI.apiKey),
            .init(name: "q", value: city),
            .init(name: "aqi", value: "no"),
            .init(name: "days", value: "3"),
            .init(name: "alerts", value: "no")
        ]
        
        RequestManager.request(
            method: .GET,
            url: url?.url ?? .init(fileURLWithPath: .init()),
            completionHandler: completionHandler
        )
    }
    
}
