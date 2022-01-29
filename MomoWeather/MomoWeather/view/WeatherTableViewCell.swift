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
//        setBackgroundView()
        subview.setWeatherData(weatherData: weatherData)
    }
    
    //TODO 매끄럽지 못한 배경색 및 코너 라운딩 이부분 너무 깔끔하지 못함
//    func setBackgroundView() {
//        GradientUtil.setGradientToView(gradientColor: GradientUtil.GradientColor.blue, view: self.contentView)
//        self.layer.cornerRadius = 15;
//        self.layer.masksToBounds = true;
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
