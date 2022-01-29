//
//  WeatherTableViewCellContent.swift
//  MomoWeather
//
//  Created by momo on 2022/01/30.
//

import UIKit

class WeatherTableViewCellContent: UIView {
    
    private static let degree: String = "°C"
            
    @IBOutlet var cityName: UILabel!
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var backgroundView: UIView!
        
    func setWeatherData(weatherData: CurrentWeatherDataResponse) {
        cityName.text = weatherData.name
        weatherIcon.image = UIImage(systemName: weatherData.weather[0].sfSymbolName)
        temperature.text = getTemperatureString(KelvinCelsiusTemperature: weatherData.main.temp)
        humidity.text = String(weatherData.main.humidity)
    }
    
    private func getTemperatureString(KelvinCelsiusTemperature: Double) -> String {
        return "\(String(format: "%.1f", KelvinCelsiusTemperature - 273.0))\(WeatherTableViewCellContent.degree)"
    }
    
    func setUp() {
        GradientUtil.setGradientToView(
            gradientColor: GradientUtil.GradientColor.gradientColors.randomElement() ?? GradientUtil.GradientColor.orange,
            view: backgroundView
        )
        setLabelTextHeightToFit(label: cityName)
        setLabelTextHeightToFit(label: temperature)
        setLabelTextHeightToFit(label: humidity)
    }
    
    private func setLabelTextHeightToFit(label: UILabel) {
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
    }
}
