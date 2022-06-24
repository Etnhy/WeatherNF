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
    }

    func configureImages(weather: Weather?) {
        guard let weather = weather else {return}

        guard let imageUrl = URL(string:"https://openweathermap.org/img/wn/\(weather.icon)@2x.png") else { return }
        self.dayWeatherImage.af.setImage(withURL: imageUrl)
        print(weather.icon)

    }
    func configureWith(hourly: Hourly?) {
        guard let hourly = hourly else { return }
        self.dayTimeLabel.text = Double(hourly.dt).getDateStringFromUnixTime(dateStyle: .none, timeStyle: .short)
        self.dayTempLabel.text = "\(Int(hourly.temp))°"
        
    }
}
