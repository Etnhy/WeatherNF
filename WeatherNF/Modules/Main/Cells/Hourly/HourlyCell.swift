//
//  HourlyCell.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 23.06.2022.
//

import UIKit
import SnapKit
class HourlyCell: UITableViewCell {
    
    static let identifier = "HourlyCell"

    var model: WeatherModelDayli?
    var presenter: HourlyPresenterProtocol?
    
    
    lazy var dailyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(UINib(nibName: "HourlyCollectionCell", bundle: .main ), forCellWithReuseIdentifier: "HourlyCollectionCell")
        view.backgroundColor = UIColor(named: "secondBackgroundColor")!

        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
        configureCollection()
        self.backgroundColor = UIColor(named: "secondBackgroundColor")!
        self.presenter = HourlyPresenter(view: self)
    }
    
    fileprivate func configureCollection() {

        addSubview(dailyCollectionView)
        dailyCollectionView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).offset(8)
            make.trailing.equalTo(self)
            make.height.equalTo(120)
        }

    }
    
}

extension HourlyCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let hourly = model?.hourly.count else { return  0 }
        return hourly
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HourlyCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCollectionCell", for: indexPath) as! HourlyCollectionCell
        cell.configureWith(hourly: model?.hourly[indexPath.item])
        cell.configureImages(weather: model!.hourly[indexPath.row].weather.first)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 110)
    }
    
}


extension HourlyCell: UICollectionViewDelegateFlowLayout {
    
    
}

extension HourlyCell: HourlyViewProtocol {
    func setView(model: WeatherModelDayli?) {
        guard let model = model else { return }
        DispatchQueue.main.async {
            self.model = model
            self.dailyCollectionView.reloadData()
        }
    }
}
