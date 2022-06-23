//
//  WeatherModel.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 23.06.2022.
//

import Foundation


struct WeatherModel: Codable {
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}

struct Current: Codable {
    let dt: Int
    let temp: Double
    let windSpeed: Double
    let humidity: Double
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case windSpeed = "wind_speed"
        case humidity
        case weather
    }
}

struct Hourly: Codable {
    let dt: Int
    let temp: Double
    let feels_like: Double
    let pressure: Double
    let wind_speed: Double
    let weather: [Weather]
}

struct Daily: Codable {
    let dt: Int
    let temp: TempDaily
    let weather: [Weather]
}

struct TempDaily: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
}

struct Weather: Codable {
    let main: String
    let description: String
    let icon: String
}
