//
//  ViewController.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 23.06.2022.
//

import UIKit
import RxSwift
import RxCocoa
class MainViewController: UIViewController {

    let dispose = DisposeBag()
    
    var model: WeatherModelDayli?
    
    var networkManager = NetworkManager()
    
     var presenter: MainViewPresenterProtocol?
//    let model = WeatherModelDayli()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MainPresenter(view: self, networkManager: networkManager)
        // Do any additional setup after loading the view.
    }


}

extension MainViewController: MainViewProtocol {
    func setWeather(model: WeatherModelDayli) {
        self.model = model
        print(model)
    }
    

    
    
}
