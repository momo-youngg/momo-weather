//
//  WeatherDetailViewController.swift
//  MomoWeather
//
//  Created by momo on 2022/01/30.
//

import UIKit

class WeatherDetailViewController: UIViewController {
        
    @IBOutlet var weatherDescription: UILabel!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var date: UILabel!
    @IBOutlet var feelsLike: UILabel!
    @IBOutlet var tempMax: UILabel!
    @IBOutlet var tempMin: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var windSpeed: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    var weatherData: CurrentWeatherDataResponse!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtil.lockOrientation(.portrait, andRotateTo: .portrait)
        
        navigationItem.title = weatherData.name
        navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtil.lockOrientation(.all)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherDescription.text = weatherData.weather[0].description.capitalized
        temperature.text = WeatherUtil.formatTemperature(kelvinCelsiusTemperature: weatherData.main.temp)
        weatherIcon.image = UIImage(systemName: weatherData.weather[0].sfSymbolName)
        date.text = WeatherUtil.dateFormatter(dateFormat: "EEEE | dd MMM yyyy").string(from: Date())
        feelsLike.text = WeatherUtil.formatTemperature(kelvinCelsiusTemperature: weatherData.main.feelsLike)
        tempMax.text = WeatherUtil.formatTemperature(kelvinCelsiusTemperature: weatherData.main.tempMax)
        tempMin.text = WeatherUtil.formatTemperature(kelvinCelsiusTemperature: weatherData.main.tempMin)
        humidity.text = WeatherUtil.formatHumidity(humidity: weatherData.main.humidity)
        pressure.text = WeatherUtil.formatPressure(pressure: weatherData.main.pressure)
        windSpeed.text = WeatherUtil.formatWindSpeed(windSpeed: weatherData.wind.speed)
        
        weatherDescription.setTextHeightToMaxFit()
        temperature.setTextHeightToMaxFit()
        date.setTextHeightToMaxFit()
        feelsLike.setTextHeightToMaxFit()
        tempMax.setTextHeightToMaxFit()
        tempMin.setTextHeightToMaxFit()
        humidity.setTextHeightToMaxFit()
        pressure.setTextHeightToMaxFit()
        windSpeed.setTextHeightToMaxFit()
        
        GradientUtil.setGradientToView(gradientColor: weatherData.weather[0].gradientColor, view: backgroundView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WeatherGraphSegue" {
            let destinationController = segue.destination as! WeatherGraphViewController
            destinationController.weatherData = self.weatherData
            destinationController.hidesBottomBarWhenPushed = true
        }
    }
}
