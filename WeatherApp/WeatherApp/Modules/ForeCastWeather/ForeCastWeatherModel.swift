//
//  ForeCastWeatherModel.swift
//  WeatherApp
//
//  Created by linhdan on 27/07/2022.
//

import UIKit

final class ForeCastWeatherModel {
    var cityName: String
    init(cityName: String) {
        self.cityName = cityName
    }
}


extension ForeCastWeatherModel: ForeCastWeatherModelProtocol {
    func getForcastData(completion: ((ForecastWeatherData?, ServiceError?) -> Void)?) {
        let service = WeatherService()
        service.forecastWeatherData(locationStr: cityName) { data,error  in
            completion?(data, error)
        }
    }
}
