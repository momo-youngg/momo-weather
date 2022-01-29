//
//  WeatherTableViewCellContent.swift
//  MomoWeather
//
//  Created by momo on 2022/01/30.
//

import UIKit

class WeatherTableViewCellContent: UIView {
            
    @IBOutlet var cityName: UILabel!
    @IBOutlet var weatherIcon: UILabel!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var backgroundView: UIView!
        
    func setWeatherData(weatherData: CurrentWeatherDataResponse) {
        cityName.text = weatherData.name
        weatherIcon.text = weatherData.weather[0].icon
        temperature.text = String(weatherData.main.temp)
        humidity.text = String(weatherData.main.humidity)

        GradientUtil.setGradientToView(gradientColor: GradientUtil.GradientColor.blue, view: backgroundView)
    }
    
}
