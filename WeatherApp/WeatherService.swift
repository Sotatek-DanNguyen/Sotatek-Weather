//
//  WeatherService.swift
//  WeatherApp
//
//  Created by linhdan on 21/07/2022.
//

import UIKit

class WeatherService {
    var errorMessage = ""
    //Networking Code
    let decoder = JSONDecoder()
    
    fileprivate func updateResults<T: Decodable>(_ data: Data, myStruct: T.Type) -> T? {
        decoder.dateDecodingStrategy = .iso8601
        do {
            let rawFeed = try decoder.decode(T.self, from: data)
            return rawFeed
        } catch let decodeError as NSError {
            errorMessage += "Decoder error: \(decodeError.localizedDescription)"
            print(errorMessage)
            return nil
        }
    }

    func weatherData(locationStr: String, completion: @escaping (CurrentWeatherData?) -> ()) {
        
        guard let url = API.locationForecast(locationStr) else { return }
        URLSession.shared.dataTask(with: url) {(data, response, error ) in
            guard let data = data else { return }
            if let currentWeatherData = self.updateResults(data, myStruct: CurrentWeatherData.self) {
                completion(currentWeatherData)
            }
            }.resume()
    }
    
    func forecastWeatherData(locationStr: String, completion: @escaping (ForecastWeatherData?) -> ()) {
        guard let url = API.locationForecast5Days(locationStr) else { return }
        URLSession.shared.dataTask(with: url) {(data, response, error ) in
            guard let data = data else { return }
            if let forecastWeatherData = self.updateResults(data, myStruct: ForecastWeatherData.self) {
                completion(forecastWeatherData)
            }
            }.resume()
    }

}
struct API {
    
    //Basic Weather URL
    static func locationForecast(_ locationName: String) -> URL?  {
        
        let apiKey = "5b65ddb2a047b887144cebe79436260f"
        let url = "https://api.openweathermap.org/data/2.5/weather?"
        let query = "q"
        let location = locationName
        
        let key = URLQueryItem(name: "APPID", value: apiKey)
        //MARK: URL EndPoints
        var baseURL = URLComponents(string: url)
        let searchString = URLQueryItem(name: query, value: location)
        
        baseURL?.queryItems?.append(searchString)
        baseURL?.queryItems?.append(key)
        return baseURL?.url
    }
    
    static func locationForecast5Days(_ locationName: String) -> URL?  {
        
        let apiKey = "5b65ddb2a047b887144cebe79436260f"
        let url = "https://api.openweathermap.org/data/2.5/forecast?"
        let query = "q"
        let location = locationName
        
        let key = URLQueryItem(name: "APPID", value: apiKey)
        //MARK: URL EndPoints
        var baseURL = URLComponents(string: url)
        let searchString = URLQueryItem(name: query, value: location)
        
        baseURL?.queryItems?.append(searchString)
        baseURL?.queryItems?.append(key)
        return baseURL?.url
    }
}



