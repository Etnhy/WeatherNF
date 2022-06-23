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
    @IBOutlet weak var mainTableView: UITableView!
    
    let dispose = DisposeBag()
    var model: WeatherModelDayli?
    var networkManager = NetworkManager()
     var presenter: MainViewPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MainPresenter(view: self, networkManager: networkManager)
        registerCells()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(named: "mainBakgroundColor")
    }

    fileprivate func registerCells() {
        self.mainTableView.register(HeadTableViewCell.self, forCellReuseIdentifier: "HeadTableViewCell")
        self.mainTableView.register(HourlyCell.self, forCellReuseIdentifier: "HourlyCell")
        self.mainTableView.register(DailyCell.self, forCellReuseIdentifier: "DailyCell")


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
            cell.backgroundColor = .yellow
            return cell
        case 1:
            let cell: HourlyCell = tableView.dequeueReusableCell(withIdentifier: "HourlyCell", for: indexPath)  as! HourlyCell
            cell.backgroundColor = .brown

            return cell
        case 2:
            let cell: DailyCell = tableView.dequeueReusableCell(withIdentifier: "DailyCell", for: indexPath) as! DailyCell
            cell.backgroundColor = .green

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
        self.model = model
        print(model)
    }
}
