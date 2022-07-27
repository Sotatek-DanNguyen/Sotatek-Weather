//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by linhdan on 26/07/2022.
//

import UIKit

class CurrentWeatherViewController: BaseViewController {

    // MARK: - Variables
    private var presenter: CurrentWeatherContract.Presenter?
    
    // MARK: - IBOutlet
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
    private var currentCityName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    @IBAction private func changeShowTemperature() {
        presenter?.invokeChangeCtoF()
    }
    
    @IBAction private func moreAction() {
        presenter?.invokeShowForeCast(self.locationTextField.text ?? "")
    }
}

extension CurrentWeatherViewController: CurrentWeatherViewProtocol {
    func set(presenter: CurrentWeatherPresenterProtocol) {
        self.presenter = presenter
    }
    
    func setupInputView() {
        locationTextField.delegate = self
        isShowWeatherView(false)
    }

    func showFahrenheit(_ isShow: Bool) {
        temperatureLabel.isHidden = isShow
        temperatureFahrenheitLabel.isHidden = !isShow
    }
    
    func updateUI(_ currentDataWeather: CurrentWeatherData?) {
        guard let currentData = currentDataWeather else {
            isShowWeatherView(false)
            locationTextField.text = ""
            currentCityName = ""
            return
        }
        isShowWeatherView(true)
        moreButton.isHidden = false
        currentCityName = currentData.cityName ?? ""
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

extension CurrentWeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter?.invokeSearch(textField.text ?? "")
        return true
    }
}


