//
//  WeatherUtil.swift
//  MomoWeather
//
//  Created by momo on 2022/01/30.
//

import Foundation

struct WeatherUtil {
    
    private static let degree: String = "°C"

    static func formatTemperature(KelvinCelsiusTemperature: Double) -> String {
        return "\(String(format: "%.1f", KelvinCelsiusTemperature - 273.0))\(WeatherUtil.degree)"
    }
    
    static func formatHumidity(humidity: Int) -> String {
        return "\(humidity)%"
    }
    
    static func formatPressure(pressure: Int) -> String {
        return "\(pressure)hPa"
    }
    
    static func formatWindSpeed(windSpeed: Double) -> String {
        return "\(String(format: "%.f", windSpeed))m/s"
    }

}
