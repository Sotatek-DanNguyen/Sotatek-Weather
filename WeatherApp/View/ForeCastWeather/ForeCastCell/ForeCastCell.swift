//
//  ForeCastCell.swift
//  WeatherApp
//
//  Created by linhdan on 22/07/2022.
//

import UIKit

class ForeCastCell: UITableViewCell {
    @IBOutlet private weak var iconImg: UIImageView!
    @IBOutlet private weak var bgImg: UIImageView!
    @IBOutlet private weak var locationLbl: UILabel!
    @IBOutlet private weak var weatherLbl: UILabel!
    @IBOutlet private weak var temperatureLbl: UILabel!
    @IBOutlet private weak var humidityLbl: UILabel!

    func updateUI(_ currentDataWeather: CurrentWeatherData, cityName: String) {
        if let weather = currentDataWeather.weather?.first {
            iconImg.image = UIImage(named: "\(String(describing: weather.icon ?? ""))-1")
            bgImg.image = UIImage(named: "\(String(describing: weather.icon ?? ""))-2")
            weatherLbl.text = (weather.description ?? "").capitalizingFirstLetter()
        }
        if let mainContent = currentDataWeather.main {
            humidityLbl.text = "\(mainContent.humidity ?? 0)%"
            temperatureLbl.text = "\(Int(mainContent.tempCelcius))°C"
        }
        locationLbl.text = cityName
        
    }
    
}
