//
//  Extension+Date.swift
//  WeatherNF
//
//  Created by Evhenii Mahlena on 24.06.2022.
//

import UIKit

extension Double {
    func getDateStringFromUnixTime(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}
