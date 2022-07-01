//
//  CurrentWeatherModel.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 26.06.2022.
//

import Foundation

struct CurrentWeatherModel: Codable {
    var coord:      Coordinates
    var weather:   [Weather]
    var base:       String
    var main:       Main
    var visibility: Int
    var wind:       Wind
    var clouds:     Clouds
    var dt:         Int
//    var sys:        Sys
    var timezone:   Int
    var id:         Int
    var name:       String
    var cod:        Int
}

struct Coordinates: Codable {
    var lon:        Double
    var lat:        Double
}

struct Main: Codable {
    var temp:       Double
//    var feels_like: Double
    var temp_min:   Double
    var temp_max:   Double
//    var pressure:   Int
    var humidity:   Int
//    var sea_level:  Int
//    var grnd_level: Int
}
struct Wind: Codable {
    var speed:      Double
    var deg:        Int
    var gust:       Double
}
struct Clouds: Codable {
    var all:         Int
}
struct Sys: Codable {
    var country:    String
    var sunrise:    Int
    var sunset:     Int
}
