//
//  WeatherUtil.swift
//  MomoWeather
//
//  Created by momo on 2022/01/30.
//

import Foundation

struct WeatherUtil {
    
    private static let degree: String = "°C"
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_EN")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "EEEE | dd MMM yyyy"
        return formatter
    }()

    static func formatTemperature(KelvinCelsiusTemperature: Double) -> String {
        return "\(String(format: "%.0f", KelvinCelsiusTemperature - 273.0))\(WeatherUtil.degree)"
    }
    
    static func formatHumidity(humidity: Int) -> String {
        return "\(humidity)%"
    }
    
    static func formatPressure(pressure: Int) -> String {
        return "\(pressure)hPa"
    }
    
    static func formatWindSpeed(windSpeed: Double) -> String {
        return "\(String(format: "%.1f", windSpeed))m/s"
    }

}
