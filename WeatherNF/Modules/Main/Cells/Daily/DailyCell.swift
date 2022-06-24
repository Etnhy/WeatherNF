//
//  DailyCell.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 23.06.2022.
//

import UIKit

class DailyCell: UITableViewCell {

    @IBOutlet weak var dailyTableView: UITableView!
    
    @IBOutlet weak var dailyTableViewHeight: NSLayoutConstraint!
    
    var presenter: DailyPresenterProtocol?
    var dailyModel: WeatherModelDayli?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
//        guard let dailyModel = dailyModel else {
//            return
//        }
//
//        let height = dailyModel.daily.count * 60
//        self.dailyTableViewHeight.constant = CGFloat(height)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        configureTableView()
    }
    fileprivate func configureTableView() {
        self.presenter = DailyPresenter(view: self)
        self.dailyTableView.register(UINib(nibName: "DailyTableCell", bundle: .main), forCellReuseIdentifier: "DailyTableCell")
        self.dailyTableView.dataSource = self
        self.dailyTableView.delegate = self
        self.dailyTableView.estimatedRowHeight = 166
        self.dailyTableView.rowHeight = UITableView.automaticDimension
    }
    
    
}

extension DailyCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dailyCount = dailyModel?.daily.count else { return 0 }
        return dailyCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DailyTableCell = tableView.dequeueReusableCell(withIdentifier: "DailyTableCell", for: indexPath) as! DailyTableCell
        cell.configureWithDaily(daily: dailyModel?.daily[indexPath.row])
        return cell
    }
    
    
}
extension DailyCell: UITableViewDelegate {
    
}

extension DailyCell: DailyViewProtocol {
    func setDaily(model: WeatherModelDayli?) {
        DispatchQueue.main.async {
            self.dailyModel = model
            self.dailyTableView.reloadData()
        }
    }
}
