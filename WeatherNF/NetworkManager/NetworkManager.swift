//
//  NetworkManager.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 23.06.2022.
//

import Foundation
import Alamofire

import RxSwift

protocol NetworkManagerLayerProtocol {
    func getWeather() -> Observable<WeatherModelDayli>
    func getWeatherWithName(cityName: String) -> Observable<CurrentWeatherModel>
    func getWeatherWithLatLon(lat: Double, lon: Double) -> Observable<CurrentWeatherModel>
}
// // https://api.openweathermap.org/data/2.5/onecall?lat=33.44&lon=-94.04&exclude=daily&appid=1f6a9d9fe34a81767d3f467c4e583f02




// https://api.openweathermap.org/data/2.5/onecall?lat=47.90&lon=33.38&exclude=hourly,daily&appid=9e64db94a738a9d0398f267a443b079c
//47.90966 33.38044
class NetworkManager: NetworkManagerLayerProtocol {

    
    

    

//    let defaultLatitude = 47.91
//    let defaultLongitude = 33.37
    //  https://api.openweathermap.org/data/2.5/onecall?lat=47.91&lon=33.37&lang=ua,uk&exclude=weekly&units=metric&appid=9e64db94a738a9d0398f267a443b079c
    //https://api.openweathermap.org/data/2.5/weather?lat=47.91&lon=33.37&appid=9e64db94a738a9d0398f267a443b079c
    //https://api.openweathermap.org/data/2.5/forecast/daily?lat=47.91&lon=33.37&appid=1f6a9d9fe34a81767d3f467c4e583f02
    static let shared = NetworkManager()
    
    
/////    //https://api.openweathermap.org/data/2.5/weather?lat=47.91&lon=33.37&appid=9e64db94a738a9d0398f267a443b079c
                                // = 47.91      // = 33.37
    func getWeatherWithLatLon(lat: Double, lon: Double) -> Observable<CurrentWeatherModel> {
        let url = "\(Net.api_url)/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=\(Net.api_key)"
        return rxRequest(url)
    }
    
    func getWeatherWithName(cityName: String) -> Observable<CurrentWeatherModel> {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&lang=ua,uk&units=metric&appid=\(Net.api_key)"
//        let url = "\(Net.api_url)weather?q=\(cityName)&appid=\(Net.api_key)"
        print(url)
       return rxRequest(url)
    }
    
    func getWeather() -> Observable<WeatherModelDayli> {
        let url = "\(Net.api_url)onecall?lat=47.91&lon=33.37&lang=ua,uk&exclude=weekly&units=metric&appid=\(Net.api_key)"
        print(url)
        return rxRequest(url)
    }
    
    fileprivate func rxRequest<T:Codable>(_ url: String) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = AF.request(url).responseDecodable { (response: DataResponse<T,AFError>) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}
