//
//  CurrentWeatherPresenter.swift
//  WeatherApp
//
//  Created by linhdan on 26/07/2022.
//
import Foundation
import UIKit

final class CurrentWeatherPresenter {
    private var view: CurrentWeatherContract.View?
    private var model: CurrentWeatherContract.Model
    private var coordinator: CurrentWeatherCoordinator
    private var isHiddenFahrenheit: Bool = true

    init(model: CurrentWeatherContract.Model, view: CurrentWeatherContract.View?, coordinator: CurrentWeatherCoordinator) {
        self.model = model
        self.view = view
        self.coordinator = coordinator
    }
}

extension CurrentWeatherPresenter: CurrentWeatherPresenterProtocol {
    func invokeShowForeCast(_ location: String) {
        coordinator.navigateToInputForecast(cityName: location)
    }
    
    func viewDidload() {
        view?.setupInputView()
        view?.showFahrenheit(!isHiddenFahrenheit)
    }
    
    func invokeSearch(_ location: String) {
        view?.startLoading()
        model.getWeatherData(location) { [weak self] data, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.hideLoading()
                if let serviceError = error {
                    self.view?.showEmptyAlert("Notice", message: serviceError.message)
                } else {
                    self.view?.updateUI(data)
                }
            }
        }
        
    }
    func invokeChangeCtoF() {
        isHiddenFahrenheit = !isHiddenFahrenheit
        view?.showFahrenheit(!isHiddenFahrenheit)
    }
}
