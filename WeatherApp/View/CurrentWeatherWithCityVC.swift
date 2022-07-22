//
//  CurrentWeatherWithCityVC.swift
//  WeatherApp
//
//  Created by linhdan on 21/07/2022.
//

import UIKit
import SVProgressHUD
class CurrentWeatherWithCityVC: UIViewController {
    @IBOutlet private weak var locationTextField: UITextField!

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var bgImageView: UIImageView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var weatherLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var temperatureFahrenheitLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var moreButton: UIButton!

    private var isHiddenFahrenheit: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        locationTextField.delegate = self
        isShowWeatherView(false)
        showFahrenheit()
    }
    private func showFahrenheit() {
        temperatureLabel.isHidden = !isHiddenFahrenheit
        temperatureFahrenheitLabel.isHidden = isHiddenFahrenheit
    }
    @IBAction private func changeShowTemperature() {
        isHiddenFahrenheit = !isHiddenFahrenheit
        showFahrenheit()
    }
    
    @IBAction private func forecastWeather() {
        let vc = ForeCastWeatherVC(nibName: "ForeCastWeatherVC", bundle: nil)
        vc.cityName = locationTextField.text
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction private func searchAction() {
        search()
    }
}

extension CurrentWeatherWithCityVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search()
        return true
    }
    private func search() {
        locationTextField.resignFirstResponder()

        if let locationStr = locationTextField.text, locationStr != "" {
            let service = WeatherService()
            SVProgressHUD.show()
            service.weatherData(locationStr: locationStr) { currentDataWeather, error  in
                SVProgressHUD.dismiss()
                DispatchQueue.main.sync { [weak self] in
                    guard let `self` = self else { return }
                    if error != nil {
                        self.updateUI(nil)
                    } else {
                        self.updateUI(currentDataWeather)
                    }
                }
            }
        }
    }
}

extension CurrentWeatherWithCityVC {
    private func updateUI(_ currentDataWeather: CurrentWeatherData?) {
        guard let currentData = currentDataWeather else {
            isShowWeatherView(false)
            return
        }
        isShowWeatherView(true)
        moreButton.isHidden = false
        if let weather = currentData.weather?.first {
            iconImageView.image = UIImage(named: "\(String(describing: weather.icon ?? ""))-1")
            bgImageView.image = UIImage(named: "\(String(describing: weather.icon ?? ""))-2")
            weatherLabel.text = (weather.description ?? "").capitalizingFirstLetter()
        }
        if let mainContent = currentData.main {
            locationLabel.text = locationTextField.text
            humidityLabel.text = "\(mainContent.humidity ?? 0)%"
            temperatureLabel.text = "\(Int(mainContent.tempCelcius))°C"
            temperatureFahrenheitLabel.text = "\(Int(mainContent.tempFahrenheit))°F"
        }
    }
    private func isShowWeatherView(_ value: Bool) {
        containerView.isHidden = !value
        moreButton.isHidden = !value
    }
}
