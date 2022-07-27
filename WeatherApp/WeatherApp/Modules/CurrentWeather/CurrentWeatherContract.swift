//
//  CurrentWeatherContract.swift
//  WeatherApp
//
//  Created by linhdan on 26/07/2022.
//

import Foundation
import UIKit

protocol CurrentWeatherContract {
    typealias Model = CurrentWeatherModelProtocol
    typealias View = CurrentWeatherViewProtocol
    typealias Presenter = CurrentWeatherPresenterProtocol
}

protocol CurrentWeatherModelProtocol {
    func getWeatherData(_ location: String?, completion: ((CurrentWeatherData?, ServiceError?) -> Void)?)
}

protocol CurrentWeatherViewProtocol: BaseViewProtocol {
    func set(presenter: CurrentWeatherContract.Presenter)
    func setupInputView()
    func updateUI(_ currentDataWeather: CurrentWeatherData?)
    func showFahrenheit(_ isShow: Bool)

}

protocol CurrentWeatherPresenterProtocol {
    func viewDidload()
    func invokeSearch(_ location: String)
    func invokeChangeCtoF()
    func invokeShowForeCast(_ location: String)
}
