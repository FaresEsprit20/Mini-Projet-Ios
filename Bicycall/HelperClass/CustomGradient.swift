//
//  CustomGradient.swift
//  Bicycall
//
//  Created by Jamil Joo on 9/1/2021.
//

import UIKit

@IBDesignable class CustomGradient: UIView {

    @IBInspectable var gradientColor1: UIColor = UIColor.white {
        didSet{
            self.setGradient()
        }
    }
    
    @IBInspectable var gradientColor2: UIColor = UIColor.white {
        didSet{
            self.setGradient()
        }
    }

    private func setGradient()
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [self.gradientColor1.cgColor, self.gradientColor2.cgColor]
        gradientLayer.frame = self.bounds
        if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer
        {
            topLayer.removeFromSuperlayer()
        }
        
        self.layer.insertSublayer(gradientLayer, at: 0)
//        self.layer.addSublayer(gradientLayer)
    }
}
