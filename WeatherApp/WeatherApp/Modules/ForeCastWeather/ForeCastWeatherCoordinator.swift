//
//  ForeCastWeatherCoordinator.swift
//  WeatherApp
//
//  Created by linhdan on 27/07/2022.
//

import UIKit

final class ForeCastWeatherCoordinator: Coordinator {
    var parent: Coordinator?
    private weak var navController: UINavigationController?
    
    init(parent: Coordinator? = nil, navController: UINavigationController?) {
        self.navController = navController
        self.parent = parent
    }
    
    func start(data: Any?) {
        guard let cityName = data as? String else { return }
        
        let foreCastWeatherView = ForeCastWeatherViewController(nibName: "ForeCastWeatherViewController", bundle: nil)
        let foreCastWeatherModel = ForeCastWeatherModel(cityName: cityName)
        let presenter = ForeCastWeatherPresenter(model: foreCastWeatherModel, view: foreCastWeatherView, coordinator: self)
        foreCastWeatherView.set(presenter: presenter)
        navController?.pushViewController(foreCastWeatherView, animated: true)
    }
    
    func backToHome() {
        self.navController?.popToRootViewController(animated: true)
    }
}
