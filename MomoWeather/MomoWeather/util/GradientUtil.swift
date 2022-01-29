//
//  GradientUtil.swift
//  MomoWeather
//
//  Created by momo on 2022.0/01.0/30.
//

import Foundation
import UIKit

struct GradientUtil {
    
    struct GradientColor {
        let light: CGColor
        let mid: CGColor
        let dark: CGColor
        
        static let orange: GradientColor = GradientColor(light: CGColor(red: 248.0/255.0, green: 215.0/255.0, blue: 89.0/255.0, alpha: 1.0),
                                                         mid: CGColor(red: 242.0/255.0, green: 165.0/255.0, blue: 74.0/255.0, alpha: 1.0),
                                                         dark: CGColor(red: 238.0/255.0, green: 124.0/255.0, blue: 62.0/255.0, alpha: 1.0))
        static let purple: GradientColor = GradientColor(light: CGColor(red: 218.0/255.0, green: 72.0/255.0, blue: 247.0/255.0, alpha: 1.0),
                                                         mid: CGColor(red: 146.0/255.0, green: 60.0/255.0, blue: 246.0/255.0, alpha: 1.0),
                                                         dark: CGColor(red: 96.0/255.0, green: 53.0/255.0, blue: 246.0/255.0, alpha: 1.0))
        static let green: GradientColor = GradientColor(light: CGColor(red: 166.0/255.0, green: 248.0/255.0, blue: 164.0/255.0, alpha: 1.0),
                                                        mid: CGColor(red: 121.0/255.0, green: 220.0/255.0, blue: 174.0/255.0, alpha: 1.0),
                                                        dark: CGColor(red: 93.0/255.0, green: 195.0/255.0, blue: 184.0/255.0, alpha: 1.0))
        static let blue: GradientColor = GradientColor(light: CGColor(red: 84.0/255.0, green: 152.0/255.0, blue: 248.0/255.0, alpha: 1.0),
                                                       mid: CGColor(red: 69.0/255.0, green: 99.0/255.0, blue: 246.0/255.0, alpha: 1.0),
                                                       dark: CGColor(red: 63.0/255.0, green: 61.0/255.0, blue: 245.0/255.0, alpha: 1.0))
        static let plum: GradientColor = GradientColor(light: CGColor(red: 233.0/255.0, green: 125.0/255.0, blue: 167.0/255.0, alpha: 1.0),
                                                       mid: CGColor(red: 187.0/255.0, green: 87.0/255.0, blue: 201.0/255.0, alpha: 1.0),
                                                       dark: CGColor(red: 157.0/255.0, green: 62.0/255.0, blue: 226.0/255.0, alpha: 1.0))
    }
        
    static func setGradientToView(gradientColor: GradientColor, view: UIView) {
        let randDouble = Double.random(in: 0.0...1.0)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [gradientColor.light, gradientColor.mid, gradientColor.dark]
        gradientLayer.startPoint = CGPoint(x: randDouble, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0 - randDouble)
        
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
    }

    
}
