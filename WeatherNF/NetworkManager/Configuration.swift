//
//  Configuration.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 23.06.2022.
//

import Foundation


struct Net {
    //"https://api.openweathermap.org/data/2.5/weather?q=Kyiv&appid=9e64db94a738a9d0398f267a443b079c"
    //9e64db94a738a9d0398f267a443b079c
    static let api_url: String = {
        guard let api_url = Bundle.main.object(forInfoDictionaryKey: "api_url") as? String else {
            fatalError()
        }
        return "\(api_url)"
    }()
    
    static let api_key: String = {
        guard let api_key = Bundle.main.object(forInfoDictionaryKey: "api_key") as? String else {
            fatalError()
        }
        return "\(api_key)"
    }()
}
