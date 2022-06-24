//
//  DailyTableCell.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 24.06.2022.
//

import UIKit
import AlamofireImage

class DailyTableCell: UITableViewCell {
    
    @IBOutlet weak var dailyDateLabel: UILabel!
    @IBOutlet weak var dailyImageView: UIImageView!
    @IBOutlet weak var dailyTempLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        isSelectedCella(selected)
    }
    
    func configureWithDaily(daily: Daily?) {
        guard let daily = daily else {return}
        self.dailyDateLabel.text = Double(daily.dt).getDateStringFromUnixTime(dateStyle: .full, timeStyle: .none, format: "E")
        self.dailyTempLabel.text = "\(Int(daily.temp.day))°"
        guard let imageUrl = URL(string:"https://openweathermap.org/img/wn/\(daily.weather.first?.icon ?? "")@2x.png" ) else  { return }
        self.dailyImageView.af.setImage(withURL: imageUrl)
        
    }
    

    
    fileprivate func isSelectedCella(_ selected: Bool) {
        if selected {
            let selectedView = SelectionView()
            self.backgroundView = selectedView
            self.backgroundView?.layer.shadowColor = UIColor(named: "blurColor")?.cgColor
            self.backgroundView?.layer.shadowOffset = CGSize(width: 4, height: 4)
            self.backgroundView?.layer.shadowRadius = 12
            self.backgroundView?.layer.shadowOpacity = 9
            changeTintColor(UIColor(named: "mainBackgroundColor"))
        } else {
            self.backgroundView = .none
            changeTintColor()
        }
    }
}

extension DailyTableCell {
    fileprivate func changeTintColor(_ color: UIColor? = .black) {
//        mainBackgroundColor
        self.dailyTempLabel.textColor = color
        self.dailyDateLabel.textColor = color
    }
}
