//
//  ForeCastWeatherVC.swift
//  WeatherApp
//
//  Created by linhdan on 22/07/2022.
//

import UIKit

class ForeCastWeatherVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var cityName:String?
    private var listWeather:[CurrentWeatherData]?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ForeCastCell", bundle: nil), forCellReuseIdentifier: "ForeCastCell")
        listWeather = []
        getForecast()
    }

}

extension ForeCastWeatherVC {
    private func getForecast() {
        if let cityName = cityName {
            let service = WeatherService()
            service.forecastWeatherData(locationStr: cityName) { data in
                DispatchQueue.main.sync { [weak self] in
                    guard let `self` = self else { return }
                    self.updateUI(data)
                }
            }
        }
    }
    private func updateUI(_ data: ForecastWeatherData?) {
        var i = 0
        listWeather?.removeAll()
        guard let data = data else { return }
        guard let listWeather = data.list else { return }
        for weatherData in listWeather {
            if (i > 4) {
                break
            }
            self.listWeather?.append(weatherData)
            i = i + 1
        }
        tableView.reloadData()
    }
}
extension ForeCastWeatherVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listWeather?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForeCastCell", for: indexPath) as! ForeCastCell
        if let list = listWeather, list.count > indexPath.row {
            cell.updateUI(list[indexPath.row],cityName: cityName ?? "")
        }
        return cell
    }
}
extension ForeCastWeatherVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }

}
