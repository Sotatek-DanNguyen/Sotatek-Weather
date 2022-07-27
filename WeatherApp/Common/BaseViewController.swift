//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by linhdan on 27/07/2022.
//

import UIKit
import SVProgressHUD
class BaseViewController: UIViewController {
}

extension BaseViewController: BaseViewProtocol {
    func startLoading() {
        SVProgressHUD.show()
    }
    func hideLoading() {
        SVProgressHUD.dismiss()
    }
    func showEmptyAlert(_ title: String, message: String) {
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert.dismiss(animated: true)
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
}
