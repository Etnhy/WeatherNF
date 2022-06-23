//
//  WeatherModel.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 23.06.2022.
//

import Foundation

struct WeatherModelDayli: Codable {
    let lat: Double
    let lon: Double
    
    let timezome: String?
    let timezone_offset: Int
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
    let alerts: [Alerts]
    
}


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
struct Weather: Codable {
    let id:     Int
    let main:   String
    let description: String
    let icon:   String
}

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

//    enum CodingKeys: String, CodingKey {
//        case sunrise = "sunrise"
//    }
}
struct Daily: Codable {
    let dt:         Int
    let sunrise:    Int?
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
struct Temp: Codable {
    let day:    Double
    let min:    Double
    let max:    Double
    let night:  Double
    let eve:    Double
    let morn:   Double
}
struct FeelsLike: Codable {
    let day:    Double
    let night:  Double
    let eve:    Double
    let morn:   Double
}
struct Alerts: Codable {
    let sender_name: String
    let event:      String
    let start:      Int
    let end:        Int
    let description: String
    let tags:       [String]
}
