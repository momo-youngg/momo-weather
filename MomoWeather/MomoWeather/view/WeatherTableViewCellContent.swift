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
        weatherIcon.image = UIImage(systemName: "heart")
        temperature.text = "\(String(weatherData.main.temp))\(WeatherTableViewCellContent.degree)"
        humidity.text = String(weatherData.main.humidity)

        GradientUtil.setGradientToView(
            gradientColor: GradientUtil.GradientColor.gradientColors.randomElement() ?? GradientUtil.GradientColor.orange,
            view: backgroundView
        )
        
        setTemp(label: cityName)
        setTemp(label: temperature)
        setTemp(label: humidity)
    }
    
    private func setTemp(label: UILabel) {
        label.minimumScaleFactor = 0.1    //or whatever suits your need
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
    }
    
}
