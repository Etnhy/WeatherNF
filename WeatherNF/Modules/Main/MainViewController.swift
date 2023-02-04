//
//  ViewController.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 23.06.2022.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation


protocol SendUrl: AnyObject {
    func sendUrl(urlString: WeatherModelDayli?)
}

class MainViewController: ParentViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    
    var presenter: MainViewPresenterProtocol?
    var networkManager = NetworkManager()
    var cityModel: CurrentWeatherModel?
    var mainModel: WeatherModelDayli?
    let dispose = DisposeBag()
    let hourly = HourlyCell()
    
    weak var sendUrl: SendUrl?
    var latitude:   Double?
    var longitude:  Double?


    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "mainBackgroundColor")
        self.presenter = MainPresenter(view: self, networkManager: networkManager)
        self.presenter?.setWeather()
        self.presenter?.setWeatherWithCityName()
        registerCells()
        setManager()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.gotNotification), name: .gotLocation, object: nil)

        
        guard let latitude = self.latitude else {return}
        guard let longitude = self.latitude else {return}
//

        DispatchQueue.main.async {
            self.presenter?.setWeatherLatLon(latitude: 24.00, longitude: 49.84 )
//            self.mainTableView.reloadData()

        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        


    }

   @objc fileprivate func gotNotification(notification: Notification) {
       guard let userInfo = notification.userInfo else { return }
       guard let latitude = userInfo["latitude"]  else { return }
       guard let longitude = userInfo["longitude"]  else { return }
       self.latitude = latitude as? Double
       self.longitude = longitude as? Double
       print(longitude, latitude)
       guard let latitude = self.latitude else {return}
       guard let longitude = self.latitude else {return}


       self.presenter?.setWeatherLatLon(latitude: latitude, longitude: longitude )
       self.mainTableView.reloadData()
   }
    
    
    fileprivate func registerCells() {
        navigationController?.navigationBar.isHidden = true
        mainTableView.allowsSelection = true
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.backgroundColor = UIColor(named: "mainBackgroundColor")!
        mainTableView.estimatedRowHeight = 166
        
        self.mainTableView.register(UINib(nibName: "HeadTableViewCell", bundle: .main), forCellReuseIdentifier: "HeadTableViewCell")
        self.mainTableView.register(HourlyCell.self, forCellReuseIdentifier: "HourlyCell")
        
        self.mainTableView.register(UINib(nibName: "DailyCell", bundle: .main), forCellReuseIdentifier: "DailyCell")
    }


    @objc fileprivate func mapButtonAction(_ sender: UIButton) {
        print("click")
        let storyboard = UIStoryboard(name: "Map", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell: HeadTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HeadTableViewCell", for: indexPath) as! HeadTableViewCell

            cell.configureCell(model: cityModel)
            cell.mapButtonOutlet.addTarget(self, action: #selector(mapButtonAction(_:)), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell: HourlyCell = tableView.dequeueReusableCell(withIdentifier: HourlyCell.identifier, for: indexPath)  as! HourlyCell
            cell.presenter?.setView(model: mainModel)
            return cell
        case 2:
            let cell: DailyCell = tableView.dequeueReusableCell(withIdentifier: "DailyCell", for: indexPath) as! DailyCell
            cell.presenter?.setView(model: mainModel)
            
            return cell
        default: break
        }
        return UITableViewCell()
    }
    
    // set privacy
    fileprivate func setManager() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
    }
    
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
}


// MARK: - set model
extension MainViewController: MainViewProtocol {
    func setWeatherCity(cityModel: CurrentWeatherModel) {
        DispatchQueue.main.async {
            self.cityModel = cityModel
            self.mainTableView.reloadData()
            print(cityModel)
        }
    }
    
    func setWeather(model: WeatherModelDayli) {
        DispatchQueue.main.async {
            self.mainModel = model
            self.mainTableView.reloadData()
        }
    }
}
