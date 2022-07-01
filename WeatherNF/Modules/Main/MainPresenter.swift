//
//  MainViewPresenter.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 23.06.2022.
//

import Foundation
import RxCocoa
import RxSwift

protocol MainViewProtocol: AnyObject {
    func setWeather(model: WeatherModelDayli)
    func setWeatherCity(cityModel: CurrentWeatherModel)
}



protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol,networkManager: NetworkManager)
    func setWeather()
    func setWeatherWithCityName()
    func setWeatherLatLon(latitude: Double, longitude: Double)
}



class MainPresenter: MainViewPresenterProtocol {

    
    let dispose = DisposeBag()
    weak var view: MainViewProtocol?
    
    var networkManager: NetworkManager!
    var weatherModel: WeatherModelDayli?
    var cityWeather: CurrentWeatherModel?
    required init(view: MainViewProtocol, networkManager: NetworkManager) {
        self.view = view
        self.networkManager = networkManager
        setWeatherWithCityName()
    }
    
    func setWeather() {
        NetworkManager.shared.getWeather()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] items in
                guard let self = self else {return}
                self.weatherModel = items
                guard let weatherModel = self.weatherModel else {return}
                self.view?.setWeather(model: weatherModel)
            } onError: { error in
                print(error)
            }.disposed(by: dispose)

    }
    
    func setWeatherWithCityName() {
        
//        NetworkManager.shared.getWeatherWithName(cityName: "Kyiv")
//            .observe(on: MainScheduler.instance)
//            .subscribe { [weak self] items in
//                guard let self = self else { return }
//                self.cityWeather = items
////                guard let weatherModel = self.weatherModel else {return}
////                self.view?.setWeather(model: weatherModel)
//                print(self.cityWeather)
//            } onError: { error in
//                print(error)
//            }.disposed(by: dispose)
        
//        NetworkManager.shared.getWeatherWithLatLon()
//            .observe(on: MainScheduler.instance)
//            .subscribe { [weak self] items in
//                guard let self = self else { return }
//                self.cityWeather = items
//                guard let cityWeather = self.cityWeather else {return}
//                self.view?.setWeatherCity(cityModel: cityWeather)
//            } onError: { error in
//                print(error)
//            }.disposed(by: dispose)

    }
    
    func setWeatherLatLon(latitude: Double, longitude: Double) {
        NetworkManager.shared.getWeatherWithLatLon(lat: latitude, lon: longitude)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] items in
                guard let self = self else { return }
                self.cityWeather = items
                guard let cityWeather = self.cityWeather else {return}
                self.view?.setWeatherCity(cityModel: cityWeather)
                print(cityWeather)
            } onError: { error in
                print(error)
            }.disposed(by: dispose)

    }
    

    
    
}
