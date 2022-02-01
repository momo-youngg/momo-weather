//
//  WeatherTableViewCell.swift
//  MomoWeather
//
//  Created by momo on 2022/01/29.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet var subview: WeatherTableViewCellContent!
            
    func setWeatherData(weatherData: CurrentWeatherDataResponse) {
        subview.setWeatherData(weatherData: weatherData)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subview.setUp()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
