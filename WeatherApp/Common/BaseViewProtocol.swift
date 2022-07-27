//
//  BaseViewProtocol.swift
//  WeatherApp
//
//  Created by linhdan on 27/07/2022.
//

import Foundation

protocol BaseViewProtocol: AnyObject {
    func hideLoading()
    func startLoading()
    func showEmptyAlert(_ title: String, message: String)
}
