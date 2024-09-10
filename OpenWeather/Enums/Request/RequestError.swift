//
//  RequestError.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 10.09.2024.
//

import Foundation

enum RequestErrors: Error {
    case decodingFailed, encodingFailed, dataIsEqualToNil, statusCodeError(statusCode: Int), responseIsEqualToNil
}
