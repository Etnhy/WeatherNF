//
//  ViewController.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 23.06.2022.
//

import UIKit
import RxSwift
import RxCocoa

protocol SendHourlyData: AnyObject {
    func sendHourlyData(data: WeatherModelDayli?)
}

class MainViewController: UIViewController {
    @IBOutlet weak var mainTableView: UITableView!
    
    let dispose = DisposeBag()
    var mainModel: WeatherModelDayli?
    var networkManager = NetworkManager()
    var presenter: MainViewPresenterProtocol?
    weak var sendHourlyData: SendHourlyData?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MainPresenter(view: self, networkManager: networkManager)
        registerCells()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(named: "mainBackgroundColor")
    }

    fileprivate func registerCells() {
        navigationController?.navigationBar.isHidden = true
        mainTableView.allowsSelection = true
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.backgroundColor = UIColor(named: "mainBackgroundColor")!
        mainTableView.estimatedRowHeight = 166
        
        self.mainTableView.register(UINib(nibName: "HeadTableViewCell", bundle: .main), forCellReuseIdentifier: "HeadTableViewCell")
        
//        self.mainTableView.register(UINib(nibName: "HourlyCell", bundle: .main), forCellReuseIdentifier: "HourlyCell")
//        self.mainTableView.register(Hourly.self, forCellReuseIdentifier: "HourlyCell")
        self.mainTableView.register(HourlyCell.self, forCellReuseIdentifier: "HourlyCell")
        
        self.mainTableView.register(UINib(nibName: "DailyCell", bundle: .main), forCellReuseIdentifier: "DailyCell")
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
            return cell
        case 1:
            let cell: HourlyCell = tableView.dequeueReusableCell(withIdentifier: HourlyCell.identifier, for: indexPath)  as! HourlyCell

            return cell
        case 2:
            let cell: DailyCell = tableView.dequeueReusableCell(withIdentifier: "DailyCell", for: indexPath) as! DailyCell

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
        self.sendHourlyData?.sendHourlyData(data: model)
        self.mainTableView.reloadData()
    }
}
