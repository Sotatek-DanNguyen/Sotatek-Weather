//
//  ForeCastWeatherPresenter.swift
//  WeatherApp
//
//  Created by linhdan on 27/07/2022.
//

import Foundation
import UIKit

final class ForeCastWeatherPresenter {
    private var view: ForeCastWeatherContract.View?
    private var model: ForeCastWeatherContract.Model
    private var coordinator: ForeCastWeatherCoordinator
    var weathers: [CurrentWeatherData] = []

    init(model: ForeCastWeatherContract.Model, view: ForeCastWeatherContract.View?, coordinator: ForeCastWeatherCoordinator) {
        self.model = model
        self.view = view
        self.coordinator = coordinator
    }
}

extension ForeCastWeatherPresenter: ForeCastWeatherPresenterProtocol {
    var cityName: String {
        return model.cityName
    }
    
    func backAction() {
        coordinator.backToHome()
    }
    
    func invokeSearch() {
        self.view?.startLoading()
        model.getForcastData() { [weak self] data, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.hideLoading()
                if let serviceError = error {
                    self.coordinator.backToHome()
                    self.view?.showEmptyAlert("Notice", message: serviceError.message)
                } else {
                    self.updateWeathersData(data)
                }
            }
        }
    }
    
    private func updateWeathersData(_ data: ForecastWeatherData?) {
        weathers.removeAll()
        guard let data = data else {
            coordinator.backToHome()
            return
        }
        guard let listWeather = data.list else {
            return
        }
        
        for (index, element) in listWeather.enumerated() {
            if (index > 4) {
                break
            }
            weathers.append(element)
        }
        view?.updateUI()
    }
    func viewDidload() {
        view?.setupInputView()
    }
}
