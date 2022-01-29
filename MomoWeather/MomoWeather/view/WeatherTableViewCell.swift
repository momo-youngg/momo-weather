//
//  WeatherTableViewCell.swift
//  MomoWeather
//
//  Created by momo on 2022/01/29.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet var cityName: UILabel!
    @IBOutlet var weather: UILabel!
    @IBOutlet var weatherIcon: UILabel!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var humidity: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
