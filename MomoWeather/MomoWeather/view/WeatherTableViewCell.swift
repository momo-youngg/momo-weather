//
//  WeatherTableViewCell.swift
//  MomoWeather
//
//  Created by momo on 2022/01/29.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet var somethingView: UIView!
        
    @IBOutlet var cityName: UILabel!
    @IBOutlet var weather: UILabel!
    @IBOutlet var weatherIcon: UILabel!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var humidity: UILabel!
    
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
        somethingView.backgroundColor = .systemPink
        somethingView.layer.cornerRadius = 15;
        somethingView.layer.masksToBounds = true;
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
