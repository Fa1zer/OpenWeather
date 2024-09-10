//
//  RequestHeaders.swift
//  OpenWeather
//
//  Created by Artemiy Zuzin on 10.09.2024.
//

import Foundation

enum RequestHeader: String {
    case applicationJson = "application/json"
    case contentType = "Content-Type"
    case authorization = "Authorization"
    case contentEncoding = "Content-Encoding"
    case contentLenght = "Content-Length"
}
