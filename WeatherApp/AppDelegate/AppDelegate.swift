//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by linhdan on 21/07/2022.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let nav = UINavigationController()
            let currentWeatherCoordinator = CurrentWeatherCoordinator(window: window, navController: nav)
            currentWeatherCoordinator.start()
            FirebaseApp.configure()
            return true
    }
}

