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
        weatherIcon.image = UIImage(systemName: weatherData.weather[0].sfSymbolName)
        temperature.text = WeatherUtil.formatTemperature(KelvinCelsiusTemperature: weatherData.main.temp)
        humidity.text = WeatherUtil.formatHumidity(humidity: weatherData.main.humidity)
    }
        
    func setUp() {
        GradientUtil.setGradientToView(
            gradientColor: GradientUtil.GradientColor.gradientColors.randomElement() ?? GradientUtil.GradientColor.orange,
            view: backgroundView
        )
        cityName.setTextHeightToMaxFit()
        temperature.setTextHeightToMaxFit()
        humidity.setTextHeightToMaxFit()
    }
        
}
