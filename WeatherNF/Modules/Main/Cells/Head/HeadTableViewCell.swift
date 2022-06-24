//
//  HeadTableViewCell.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 23.06.2022.
//

import UIKit
import AlamofireImage

// http://openweathermap.org/img/wn/03d@2x.png

class HeadTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(model: WeatherModelDayli?) {
        guard let model = model else { return }
        self.countryLabel.text = model.timezone
        self.currentDateLabel.text = Double(model.current.dt).getDateStringFromUnixTime(dateStyle: .full, timeStyle: .none)
        self.temperatureLabel.text = "\(Int(model.current.temp))°/\(Int(model.current.feels_like))°"
        self.humidityLabel.text = "\(model.current.humidity)%"
        self.windLabel.text = "\(Int(model.current.wind_speed))м/сек"
        guard let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(model.current.weather[0].icon)@2x.png") else {return}
        headerImageView.af.setImage(withURL: imageUrl)
    }
    
    @IBAction func locationButtonAction(_ sender: UIButton) {
        print("go to map")
    }
    
}

