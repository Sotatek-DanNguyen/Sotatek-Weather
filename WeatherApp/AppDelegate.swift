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
            let vc = CurrentWeatherWithCityVC(nibName: "CurrentWeatherWithCityVC", bundle: nil)
            let nav = UINavigationController(rootViewController: vc)
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
            FirebaseApp.configure()
            return true
    }
}

