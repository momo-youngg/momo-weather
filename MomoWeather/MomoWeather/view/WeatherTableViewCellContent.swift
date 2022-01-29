//
//  WeatherTableViewCellContent.swift
//  MomoWeather
//
//  Created by momo on 2022/01/30.
//

import UIKit

class WeatherTableViewCellContent: UIView {
            
    @IBOutlet var cityName: UILabel!
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var backgroundView: UIView!
        
    func setWeatherData(weatherData: CurrentWeatherDataResponse) {
        cityName.text = weatherData.name
        weatherIcon.image = UIImage(systemName: "heart")
//        weatherData.weather[0].icon
        temperature.text = String(weatherData.main.temp)
        humidity.text = String(weatherData.main.humidity)

        GradientUtil.setGradientToView(gradientColor: GradientUtil.GradientColor.blue, view: backgroundView)
        
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
