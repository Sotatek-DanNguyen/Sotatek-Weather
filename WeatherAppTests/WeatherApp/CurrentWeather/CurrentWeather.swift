//
//  CurrentWeather.swift
//  WeatherAppTests
//
//  Created by linhdan on 27/07/2022.
//

import XCTest

class CurrentWeather: XCTestCase {

    func testApiGetCurrentWeather() throws {
        var existError: ServiceError?
        let exp = expectation(description: "Get Weather Data")
        var entity: CurrentWeatherData?
        let service = WeatherService()
        let cityName = "Hanoi"
        service.weatherData(locationStr: cityName) { data, error in
            existError = error
            entity = data
            exp.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            guard let result = existError else {
                if entity?.weather != nil {
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
        let exp = expectation(description: "Get Weather Data")
        let service = WeatherService()
        let cityName = ""
        service.weatherData(locationStr: cityName) { data, error in
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
        let exp = expectation(description: "Get Weather Data")
        let service = WeatherService()
        let cityName = "Hanoi"
        service.weatherData(locationStr: cityName) { data, error in
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
