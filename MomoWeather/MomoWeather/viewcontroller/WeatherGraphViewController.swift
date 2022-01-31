//
//  WeatherGraphViewController.swift
//  MomoWeather
//
//  Created by momo on 2022/02/01.
//

import UIKit

class WeatherGraphViewController: UIViewController {
    
    @IBOutlet var graphView: GraphView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        let graphInfo: GraphInfo = GraphInfo(graphKeyInfo: [
            "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
        ],
                                                       graphValueInfo: [
                                                        GraphInfo.GraphValueInfo(description: "1번",
                                                                                 dimension: "m/s",
                                                                                 outerColor: UIColor.blue,
                                                                                 innerColor: UIColor.black,
                                                                                 innerRadius: 8.0,
                                                                                 outerRadius: 12.0,
                                                                                 values: [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]),
                                                        GraphInfo.GraphValueInfo(description: "2번",
                                                                                 dimension: "m/s",
                                                                                 outerColor: UIColor.red,
                                                                                 innerColor: UIColor.black,
                                                                                 innerRadius: 8.0,
                                                                                 outerRadius: 12.0,
                                                                                 values: [20.0, 18.0, 16.0, 14.0, 11.0, 1.0, -1.0, -3.0, 0.0, 15.0]),
                                                       ])
        graphView.graphInfo = graphInfo
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
