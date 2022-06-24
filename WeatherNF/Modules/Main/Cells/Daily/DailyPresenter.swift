//
//  DailyPresenter.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 24.06.2022.
//

import Foundation

protocol DailyViewProtocol: AnyObject {
    func setDaily(model:WeatherModelDayli?)
}

protocol DailyPresenterProtocol: AnyObject {
    init(view: DailyViewProtocol)
    func setView(model: WeatherModelDayli?)

}

class DailyPresenter: DailyPresenterProtocol {

    weak var view: DailyViewProtocol?
    required init(view: DailyViewProtocol) {
        self.view = view
    }
    
    func setView(model: WeatherModelDayli?) {
        self.view?.setDaily(model: model)
    }
    
    

    
    
}
