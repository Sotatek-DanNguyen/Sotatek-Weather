//
//  CurrentWeatherWithCityVC.swift
//  WeatherApp
//
//  Created by linhdan on 21/07/2022.
//

import UIKit
import SVProgressHUD
class CurrentWeatherWithCityVC: UIViewController {
    @IBOutlet private weak var locationTf: UITextField!

    @IBOutlet private weak var iconImg: UIImageView!
    @IBOutlet private weak var bgImg: UIImageView!
    @IBOutlet private weak var locationLbl: UILabel!
    @IBOutlet private weak var weatherLbl: UILabel!
    @IBOutlet private weak var temperatureLbl: UILabel!
    @IBOutlet private weak var temperatureFahrenheitLbl: UILabel!
    @IBOutlet private weak var humidityLbl: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var moreBtn: UIButton!

    private var isHiddenFahrenheit: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        locationTf.delegate = self
        isShowWeatherView(false)
        showFahrenheit()
    }
    private func showFahrenheit() {
        temperatureLbl.isHidden = !isHiddenFahrenheit
        temperatureFahrenheitLbl.isHidden = isHiddenFahrenheit
    }
    @IBAction private func changeShowTemperature() {
        isHiddenFahrenheit = !isHiddenFahrenheit
        showFahrenheit()
    }
    
    @IBAction private func forecastWeather() {
        let vc = ForeCastWeatherVC(nibName: "ForeCastWeatherVC", bundle: nil)
        vc.cityName = locationTf.text
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
        locationTf.resignFirstResponder()

        if let locationStr = locationTf.text, locationStr != "" {
            let service = WeatherService()
            SVProgressHUD.show()
            service.weatherData(locationStr: locationStr) { currentDataWeather in
                SVProgressHUD.dismiss()
                DispatchQueue.main.sync { [weak self] in
                    guard let `self` = self else { return }
                    self.updateUI(currentDataWeather)
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
        moreBtn.isHidden = false
        if let weather = currentData.weather?.first {
            iconImg.image = UIImage(named: "\(String(describing: weather.icon ?? ""))-1")
            bgImg.image = UIImage(named: "\(String(describing: weather.icon ?? ""))-2")
            weatherLbl.text = (weather.description ?? "").capitalizingFirstLetter()
        }
        if let mainContent = currentData.main {
            locationLbl.text = locationTf.text
            humidityLbl.text = "\(mainContent.humidity ?? 0)%"
            temperatureLbl.text = "\(Int(mainContent.tempCelcius))°C"
            temperatureFahrenheitLbl.text = "\(Int(mainContent.tempFahrenheit))°F"
        }
    }
    private func isShowWeatherView(_ value: Bool) {
        containerView.isHidden = !value
        moreBtn.isHidden = !value
    }
}
