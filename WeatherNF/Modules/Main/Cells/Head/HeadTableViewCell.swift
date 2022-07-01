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
    
    
    @IBOutlet weak var mapButtonOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func configureCell(model: WeatherModelDayli?) {
//        guard let model = model else { return }
//        self.countryLabel.text = model.timezone
//        self.currentDateLabel.text = Double(model.current.dt).getDateStringFromUnixTime(dateStyle: .full, timeStyle: .none,format: nil)
//        self.temperatureLabel.text = "\(Int(model.current.temp))°/\(Int(model.current.feels_like))°"
//        self.humidityLabel.text = "\(model.current.humidity)%"
//        self.windLabel.text = "\(Int(model.current.wind_speed))м/сек"
//        guard let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(model.current.weather[0].icon)@2x.png") else {return}
//        headerImageView.af.setImage(withURL: imageUrl)
//    }
    func configureCell(model: CurrentWeatherModel?) {
        guard let model = model else { return }
        self.countryLabel.text = model.name
        self.currentDateLabel.text = Double(model.dt).getDateStringFromUnixTime(dateStyle: .full, timeStyle: .none,format: nil)
        self.temperatureLabel.text = "\(Int(model.main.temp_min))°/\(Int(model.main.temp_max))°"
        self.humidityLabel.text = "\(model.main.humidity)%"
        self.windLabel.text = "\(Int(model.wind.speed))м/сек"
        guard let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(model.weather[0].icon)@2x.png") else {return}
        headerImageView.af.setImage(withURL: imageUrl)
    }

    
    
    @IBAction func mapButtonAction(_ sender: UIButton) {
        print("click")
        let storyboard = UIStoryboard(name: "Map", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        nav.pushViewController(vc, animated: true)

    }
    
    
}

