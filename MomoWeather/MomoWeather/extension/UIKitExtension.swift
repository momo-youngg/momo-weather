//
//  UIKitExtension.swift
//  MomoWeather
//
//  Created by momo on 2022/01/30.
//

import Foundation
import UIKit

extension UILabel {
    
    func setTextHeightToMaxFit() {
        self.minimumScaleFactor = 0.1
        self.adjustsFontSizeToFitWidth = true
        self.lineBreakMode = .byClipping
        self.numberOfLines = 0
    }
}
