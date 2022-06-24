//
//  HourlyCollectionCell.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 24.06.2022.
//

import UIKit
import AlamofireImage

class HourlyCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var dayTimeLabel: UILabel!
    @IBOutlet weak var dayWeatherImage: UIImageView!
    @IBOutlet weak var dayTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureWith(hourly: Hourly?) {
        guard let hourly = hourly else { return }

        self.dayTempLabel.text = Double(hourly.dt).getDateStringFromUnixTime(dateStyle: .none, timeStyle: .short)
        
        guard let imageUrl = URL(string:"https://openweathermap.org/img/wn/\(hourly.weather.first!.icon)") else { return }
        self.dayWeatherImage.af.setImage(withURL: imageUrl)
        self.dayTempLabel.text = "\(hourly.temp)"
    }
}
