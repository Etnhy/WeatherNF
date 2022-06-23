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
}
// // https://api.openweathermap.org/data/2.5/onecall?lat=33.44&lon=-94.04&exclude=daily&appid=1f6a9d9fe34a81767d3f467c4e583f02




// https://api.openweathermap.org/data/2.5/onecall?lat=47.90&lon=33.38&exclude=hourly,daily&appid=9e64db94a738a9d0398f267a443b079c
//47.90966 33.38044
class NetworkManager: NetworkManagerLayerProtocol {

    
    static let shared = NetworkManager()
    
    
    func getWeather() -> Observable<WeatherModelDayli> {
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=33.44&lon=-94.04&exclude=weekly&appid=1f6a9d9fe34a81767d3f467c4e583f02"
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
