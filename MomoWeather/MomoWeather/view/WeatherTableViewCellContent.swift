//
//  WeatherTableViewCellContent.swift
//  MomoWeather
//
//  Created by momo on 2022/01/30.
//

import UIKit

class WeatherTableViewCellContent: UIView {
            
    @IBOutlet var cityName: UILabel!
    @IBOutlet var weather: UILabel!
    @IBOutlet var weatherIcon: UILabel!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var humidity: UILabel!
    
    var backgroundView: UIView?
        
    func setWeatherData(weatherData: CurrentWeatherDataResponse) {
        cityName.text = weatherData.name
        weather.text = weatherData.weather[0].main
        weatherIcon.text = weatherData.weather[0].icon
        temperature.text = String(weatherData.main.temp)
        humidity.text = String(weatherData.main.humidity)
        
        setBackgroundView()
    }
    
    //TODO 매끄럽지 못한 배경색 및 코너 라운딩 이부분 너무 깔끔하지 못함
    func setBackgroundView() {
        if (backgroundView == nil) {
            backgroundView = UIView()
            addSubview(backgroundView!)
            sendSubviewToBack(backgroundView!)
            backgroundView!.translatesAutoresizingMaskIntoConstraints = false
            backgroundView!.topAnchor.constraint(equalTo: topAnchor).isActive = true
            backgroundView!.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            backgroundView!.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            backgroundView!.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }

        GradientUtil.setGradientToView(gradientColor: GradientUtil.GradientColor.blue, view: self)
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = true;
    }

    
}
