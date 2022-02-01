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
        // Do any additional setup after loading the view.
        
        GradientUtil.setGradientToView(gradientColor: weatherData.weather[0].gradientColor, view: backgroundView)
        titleLabel.setTextHeightToMaxFit()
        
        openWhetherClient.get5Day3HourForecastData(lat: weatherData.coord.lat,
                                                   lon: weatherData.coord.lon) { result, forecast in
            let graphInfo: GraphInfo = GraphInfo(graphKeyInfo: forecast.graphKeyInfo,
                                                 graphValueInfo: [
                                                    GraphInfo.GraphValueInfo(description: "최저기온",
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
                                                                             values: forecast.graphMaxTempValueInfo)
                                                 ])
            
            DispatchQueue.main.async {
                self.graphView.graphInfo = graphInfo
            }
            
        }
        
        
//        let graphInfo: GraphInfo = GraphInfo(graphKeyInfo: [
//            "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
//        ],
//                                                       graphValueInfo: [
//                                                        GraphInfo.GraphValueInfo(description: "1번",
//                                                                                 dimension: "m/s",
//                                                                                 outerColor: UIColor.blue,
//                                                                                 innerColor: UIColor.black,
//                                                                                 innerRadius: 8.0,
//                                                                                 outerRadius: 12.0,
//                                                                                 values: [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]),
//                                                        GraphInfo.GraphValueInfo(description: "2번",
//                                                                                 dimension: "m/s",
//                                                                                 outerColor: UIColor.red,
//                                                                                 innerColor: UIColor.black,
//                                                                                 innerRadius: 8.0,
//                                                                                 outerRadius: 12.0,
//                                                                                 values: [20.0, 18.0, 16.0, 14.0, 11.0, 1.0, -1.0, -3.0, 0.0, 15.0]),
//                                                       ])
//        graphView.graphInfo = graphInfo
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
