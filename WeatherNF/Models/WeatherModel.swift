//
//  WeatherModel.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 23.06.2022.
//

import Foundation


// MARK: - WeatherModelDayli
struct WeatherModelDayli: Codable {
    let timezone: String
    let timezone_offset: Int
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
    
}

// MARK: - Current
struct Current: Codable {
    let dt:         Int
    let sunrise:    Int
    let temp:       Double
    let feels_like: Double
    let pressure:   Int
    let humidity:   Int
    let dew_point:  Double
    let uvi:        Double
    let clouds:     Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg:   Int
    let wind_gust:  Double?
    
    let weather: [Weather]
}

// MARK: - Weather
struct Weather: Codable {
    let id:     Int
    let main:   String
    let description: String
    let icon:   String
}

// MARK: - Hourly
struct Hourly: Codable {
    let dt:         Int
    let sunrise:    Int?
    let temp:       Double
    let feels_like: Double
    let pressure:   Int
    let humidity:   Int
    let dew_point:  Double
    let uvi:        Double
    let clouds:     Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg:   Int
    let wind_gust:  Double
    let weather:    [Weather]


}

// MARK: - Daily
struct Daily: Codable {
    let dt:         Int
    let sunrise:    Int
    let sunset:     Int
    let moonrise:   Int
    let moonset:    Int
    let moon_phase: Double
    let temp:       Temp
    let feels_like: FeelsLike
    let pressure:   Int
    let humidity:   Int
    let dew_point:  Double
    let wind_speed: Double
    let wind_deg:   Double
    let wind_gust:  Double
    let weather:    [Weather]
    let clouds:     Int
    let pop:        Double
    let uvi:        Double
}

// MARK: - Temp
struct Temp: Codable {
    let day:    Double
    let min:    Double
    let max:    Double
    let night:  Double
    let eve:    Double
    let morn:   Double
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day:    Double
    let night:  Double
    let eve:    Double
    let morn:   Double
}

// MARK: - Alerts
struct Alerts: Codable {
    let sender_name: String
    let event:      String
    let start:      Int
    let end:        Int
    let description: String
    let tags:       [String]
}
