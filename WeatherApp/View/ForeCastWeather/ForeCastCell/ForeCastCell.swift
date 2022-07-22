//
//  ForeCastCell.swift
//  WeatherApp
//
//  Created by linhdan on 22/07/2022.
//

import UIKit

class ForeCastCell: UITableViewCell {
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var bgImageView: UIImageView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var weatherLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!

    func updateUI(_ currentDataWeather: CurrentWeatherData, cityName: String) {
        if let weather = currentDataWeather.weather?.first {
            iconImageView.image = UIImage(named: "\(String(describing: weather.icon ?? ""))-1")
            bgImageView.image = UIImage(named: "\(String(describing: weather.icon ?? ""))-2")
            weatherLabel.text = (weather.description ?? "").capitalizingFirstLetter()
        }
        if let mainContent = currentDataWeather.main {
            humidityLabel.text = "\(mainContent.humidity ?? 0)%"
            temperatureLabel.text = "\(Int(mainContent.tempCelcius))°C"
        }
        locationLabel.text = cityName
        
    }
    
}
