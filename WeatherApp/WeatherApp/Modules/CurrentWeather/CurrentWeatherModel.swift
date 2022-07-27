//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by linhdan on 27/07/2022.
//

final class CurrentWeatherModel {
}

extension CurrentWeatherModel: CurrentWeatherModelProtocol {
    func getWeatherData(_ location: String?, completion: ((CurrentWeatherData?, ServiceError?) -> Void)?) {
        let service = WeatherService()
        service.weatherData(locationStr: location ?? "") { data, error in
            completion?(data, error)
        }
    }
}
