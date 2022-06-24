//
//  ViewController.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 23.06.2022.
//

import UIKit
import RxSwift
import RxCocoa

protocol SendUrl: AnyObject {
    func sendUrl(urlString: WeatherModelDayli?)
}

class MainViewController: ParentViewController {
    @IBOutlet weak var mainTableView: UITableView!
    
    let dispose = DisposeBag()
    var mainModel: WeatherModelDayli?
    var networkManager = NetworkManager()
    var presenter: MainViewPresenterProtocol?
    
    
    weak var sendUrl: SendUrl?
    
    let hourly = HourlyCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MainPresenter(view: self, networkManager: networkManager)
        registerCells()
        view.backgroundColor = UIColor(named: "mainBackgroundColor")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
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

            cell.configureCell(model: mainModel)
            cell.mapButtonOutlet.addTarget(self, action: #selector(mapButtonAction(_:)), for: .touchUpInside)
            
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
    
    
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
}


// MARK: - set model
extension MainViewController: MainViewProtocol {
    func setWeather(model: WeatherModelDayli) {
        self.mainModel = model
        self.mainTableView.reloadData()
    }
}

extension MapViewController: SendLocation {
    func sendLocation(latitude: Double?, longitude: Double?) {
        print(latitude)
        print(longitude)
    }
    
    
}
