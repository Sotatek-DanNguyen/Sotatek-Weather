//
//  DateExtension.swift
//  WeatherApp
//
//  Created by linhdan on 26/07/2022.
//

import Foundation

extension Date {
    static func getNextDate(count: Int) -> String {
        let calendar = Calendar.current
        let today = Date()
        let midnight = calendar.startOfDay(for: today)
        let tomorrow = calendar.date(byAdding: .day, value: count, to: midnight)!
        return tomorrow.getDateString()
    }
    
    private func getDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter.string(from: self)
    }
}
