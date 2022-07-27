//
//  ForeCastWeather.swift
//  WeatherAppTests
//
//  Created by linhdan on 27/07/2022.
//

import XCTest

class ForeCastWeather: XCTestCase {
    
    func testApiGetForeCastWeather() throws {
        var existError: ServiceError?
        let exp = expectation(description: "Get ForeCast Data")
        var entity: ForecastWeatherData?
        let service = WeatherService()
        let cityName = "Hanoi"
        service.forecastWeatherData(locationStr: cityName) { data, error in
            existError = error
            entity = data
            exp.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            guard let result = existError else {
                if entity != nil {
                    XCTAssertTrue(true)
                } else {
                    XCTFail("Unexpected response")
                }
                return
            }
            XCTFail(result.message)
        }
    }
    
    func testApiGetCurrentWeatherEmptyCityName() throws {
        var existError: ServiceError?
        let exp = expectation(description: "Get ForeCast Data")
        let service = WeatherService()
        let cityName = ""
        service.forecastWeatherData(locationStr: cityName) { data, error in
            existError = error
            exp.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            guard let result = existError else {
                XCTFail("Unexpected response")
                return
            }
            if result.message == "Not found Data" {
                XCTAssertTrue(true)
                return
            }
            XCTFail(result.message)
        }
    }
//MARK: Turn off Internet
    func testApiGetCurrentWeatherNoInternet() throws {
        var existError: ServiceError?
        let exp = expectation(description: "Get ForeCast Data")
        let service = WeatherService()
        let cityName = "Hanoi"
        service.forecastWeatherData(locationStr: cityName) { data, error in
            existError = error
            exp.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            guard let result = existError else {
                XCTFail("Unexpected response")
                return
            }
            if result.message == "Internet Connection Error" {
                XCTAssertTrue(true)
                return
            }
            XCTFail(result.message)
        }
    }
}

