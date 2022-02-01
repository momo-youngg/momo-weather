//
//  WeatherUtil.swift
//  MomoWeather
//
//  Created by momo on 2022/01/30.
//

import Foundation

struct WeatherUtil {
    
    static let celsiusDegree: String = "°C"
    static let percent: String = "%"
    static let hectoPascal: String = "hPa"
    static let meterPerSec: String = "m/s"
    
    static func dateFormatter(dateFormat: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_EN")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = dateFormat
        return formatter
    }
    
    static func transformFromKelvinToCelsious(kelvinCelsiusTemperature: Double) -> Double{
        kelvinCelsiusTemperature - 273.0
    }

    static func formatTemperature(kelvinCelsiusTemperature: Double) -> String {
        return "\(String(format: "%.0f", kelvinCelsiusTemperature - 273.0))\(WeatherUtil.celsiusDegree)"
    }
    
    static func formatHumidity(humidity: Int) -> String {
        return "\(humidity)\(percent)"
    }
    
    static func formatPressure(pressure: Int) -> String {
        return "\(pressure)\(hectoPascal)"
    }
    
    static func formatWindSpeed(windSpeed: Double) -> String {
        return "\(String(format: "%.1f", windSpeed))\(meterPerSec)"
    }

}
