//
//  ForeCastWeatherVC.swift
//  WeatherApp
//
//  Created by linhdan on 22/07/2022.
//

import UIKit
import SVProgressHUD
class ForeCastWeatherVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var cityName:String?
    private var listWeather: [CurrentWeatherData]?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ForeCastCell", bundle: nil), forCellReuseIdentifier: "ForeCastCell")
        listWeather = []
        getForecast()
    }
    @IBAction private func backAction() {
        navigationController?.popViewController(animated: true)
    }
}

extension ForeCastWeatherVC {
    private func getForecast() {
        if let cityName = cityName {
            let service = WeatherService()
            SVProgressHUD.show()
            service.forecastWeatherData(locationStr: cityName) { data,error  in
                SVProgressHUD.dismiss()
                DispatchQueue.main.async { [weak self] in
                    guard let `self` = self else { return }
                    if error == nil {
                        self.updateUI(data)
                    } else {
                        self.updateUI(nil)
                        self.showEmptyAlert("Notice", message: error?.message ?? "")
                    }
                }
            }
        }
    }
    private func updateUI(_ data: ForecastWeatherData?) {
        var i = 0
        listWeather?.removeAll()
        guard let data = data else {
            navigationController?.popViewController(animated: true)
            return
        }
        guard let listWeather = data.list else {
            return
        }
        for weatherData in listWeather {
            if (i > 4) {
                break
            }
            self.listWeather?.append(weatherData)
            i = i + 1
        }
        tableView.reloadData()
    }
    private func dateWithIndex(index: Int) {
        
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
            let dateStr = Date.getNextDate(count: indexPath.row)
            cell.updateUI(list[indexPath.row],cityName: cityName ?? "", dateStr: dateStr)
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
}
extension ForeCastWeatherVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }

}

