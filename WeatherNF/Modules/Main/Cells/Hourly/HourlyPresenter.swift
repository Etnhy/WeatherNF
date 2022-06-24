//
//  HourlyPresenter.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 24.06.2022.
//

import Foundation

protocol HourlyViewProtocol: AnyObject {
    func setView(model: WeatherModelDayli?)
    
}

protocol HourlyPresenterProtocol: AnyObject {
    init(view:HourlyViewProtocol)
    func setView(model: WeatherModelDayli?)
}

class HourlyPresenter: HourlyPresenterProtocol {

    
    var model: WeatherModelDayli?
    weak var view: HourlyViewProtocol?
    
    required init(view: HourlyViewProtocol) {
        self.view = view
    }
    
    func setView(model: WeatherModelDayli?) {
        self.view?.setView(model: model)
    }
    
    
}
