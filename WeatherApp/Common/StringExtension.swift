//
//  StringExtension.swift
//  WeatherApp
//
//  Created by linhdan on 26/07/2022.
//

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
