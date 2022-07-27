//
//  ForeCastWeatherViewController.swift
//  WeatherApp
//
//  Created by linhdan on 27/07/2022.
//

import UIKit

class ForeCastWeatherViewController: BaseViewController {
    // MARK: - Variables
    private var presenter: ForeCastWeatherContract.Presenter?
    private var listWeather: [CurrentWeatherData]?
    private var heightCell: CGFloat = 136
    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidload()
    }
    
    @IBAction private func backAction() {
        presenter?.backAction()
    }
}

extension ForeCastWeatherViewController: ForeCastWeatherViewProtocol {
    func set(presenter: ForeCastWeatherPresenterProtocol) {
        self.presenter = presenter
    }
    
    func setupInputView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ForeCastCell", bundle: nil), forCellReuseIdentifier: "ForeCastCell")
        presenter?.invokeSearch()
    }
    
    func updateUI() {
        tableView.reloadData()
    }
}

extension ForeCastWeatherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.weathers.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForeCastCell", for: indexPath) as! ForeCastCell
        if let list = presenter?.weathers, list.count > indexPath.row {
            let dateStr = Date.getNextDate(count: indexPath.row)
            cell.updateUI(list[indexPath.row], cityName: presenter?.cityName ?? "", dateStr: dateStr)
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
}
extension ForeCastWeatherViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCell
    }

}

