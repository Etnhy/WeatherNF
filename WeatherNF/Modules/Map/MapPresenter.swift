//
//  MapPresenter.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 25.06.2022.
//

import Foundation

protocol MapViewProtocol:AnyObject {
    func setCountries(countries: [String])
}

protocol MapPresenterProtocol: AnyObject {
    init(view: MapViewProtocol)
    func getContries()
}

class MapViewPresenter: MapPresenterProtocol {

    weak var view: MapViewProtocol?
    
    required init(view: MapViewProtocol) {
        self.view = view
        getContries()
    }
    
    func getContries() {
//        let countryList = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
//
//        self.view?.setCountries(countries: cityList)
    }
    
    
    
}
