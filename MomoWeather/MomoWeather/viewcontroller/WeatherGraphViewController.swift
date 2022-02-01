//
//  WeatherGraphViewController.swift
//  MomoWeather
//
//  Created by momo on 2022/02/01.
//

import UIKit

class WeatherGraphViewController: UIViewController {
    
    @IBOutlet var graphView: GraphView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var titleLabel: UILabel!
    var weatherData: CurrentWeatherDataResponse!
    let openWhetherClient: OpenWeatherClient = OpenWeatherClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.setTextHeightToMaxFit()
        GradientUtil.setGradientToView(gradientColor: weatherData.weather[0].gradientColor, view: backgroundView)
        
        openWhetherClient.get5Day3HourForecastData(lat: weatherData.coord.lat,
                                                   lon: weatherData.coord.lon) { result, forecast in
            let graphInfo: GraphInfo = GraphInfo(graphKeyInfo: forecast.graphKeyInfo,
                                                 leftGraphValueInfo: [GraphInfo.GraphValueInfo(description: "최저기온",
                                                                                               dimension: "도씨",
                                                                                               outerColor: .blue,
                                                                                               innerColor: .white,
                                                                                               innerRadius: 8.0,
                                                                                               outerRadius: 12.0,
                                                                                               values: forecast.graphMinTempValueInfo),
                                                                      GraphInfo.GraphValueInfo(description: "최고기온",
                                                                                               dimension: "도씨",
                                                                                               outerColor: .red,
                                                                                               innerColor: .white,
                                                                                               innerRadius: 8.0,
                                                                                               outerRadius: 12.0,
                                                                                               values: forecast.graphMaxTempValueInfo)],
                                                 rightGraphValueInffo: [GraphInfo.GraphValueInfo(description: "습도",
                                                                                                 dimension: "%",
                                                                                                 outerColor: .black,
                                                                                                 innerColor: .white,
                                                                                                 innerRadius: 8.0,
                                                                                                 outerRadius: 12.0,
                                                                                                 values: forecast.graphHumidityTempValueInfo)])
            
            DispatchQueue.main.async {
                self.graphView.graphInfo = graphInfo
            }
        }
    }
    
}
