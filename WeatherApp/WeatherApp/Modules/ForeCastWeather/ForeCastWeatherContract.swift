//
//  ForeCastWeatherContract.swift
//  WeatherApp
//
//  Created by linhdan on 27/07/2022.
//

import Foundation
import UIKit

protocol ForeCastWeatherContract {
    typealias Model = ForeCastWeatherModelProtocol
    typealias View = ForeCastWeatherViewProtocol
    typealias Presenter = ForeCastWeatherPresenterProtocol
}

protocol ForeCastWeatherModelProtocol {
    func getForcastData(completion: ((ForecastWeatherData?, ServiceError?) -> Void)?)
    var cityName: String { get set }
}

protocol ForeCastWeatherViewProtocol: BaseViewProtocol {
    func set(presenter: ForeCastWeatherContract.Presenter)
    func setupInputView()
    func updateUI()

}

protocol ForeCastWeatherPresenterProtocol {
    func viewDidload()
    func backAction()
    func invokeSearch()
    var cityName: String { get }
    var weathers: [CurrentWeatherData] { get set }

}
