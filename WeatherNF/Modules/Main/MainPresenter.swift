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
}



protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol,networkManager: NetworkManager)
    func setWeather()
}



class MainPresenter: MainViewPresenterProtocol {
    
    let dispose = DisposeBag()
    weak var view: MainViewProtocol?
    
    var networkManager: NetworkManager!
    var weatherModel: WeatherModelDayli?
    
    required init(view: MainViewProtocol, networkManager: NetworkManager) {
        self.view = view
        self.networkManager = networkManager
        setWeather()
    }
    
    func setWeather() {
        NetworkManager.shared.getWeather()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] items in
                guard let self = self else {return}
                self.weatherModel = items
                self.view?.setWeather(model: self.weatherModel!)
            } onError: { error in
                print(error)
            }.disposed(by: dispose)

    }
    
    
}
