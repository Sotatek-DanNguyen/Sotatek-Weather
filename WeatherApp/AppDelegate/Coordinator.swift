//
//  Coordinator.swift
//  WeatherApp
//
//  Created by linhdan on 26/07/2022.
//

import Foundation

protocol Coordinator: AnyObject {
    func start(data: Any?)
}

extension Coordinator {
    func start(data: Any? = nil) {
        self.start(data: nil)
    }
}
