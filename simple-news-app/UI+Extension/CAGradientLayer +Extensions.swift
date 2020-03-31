//
//  Navigation+Extensions.swift
//  simple-news-app
//
//  Created by Hamzhya Salsatinnov Hairy on 01/04/20.
//  Copyright © 2020 Hamzhya Salsatinnov Hairy. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    
    class func primaryGradient(on view: UIView) -> UIImage? {
        let gradient = CAGradientLayer()
        let flareRed = UIColor(hexString: "#FE067C")
        let flareOrange = UIColor(hexString: "#EF171C")
        var bounds = view.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        gradient.colors = [flareRed.cgColor, flareOrange.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        return gradient.createGradientImage(on: view)
    }
    
    class func secondaryGradient(on view: UIView) -> UIImage? {
        let gradient = CAGradientLayer()
        let flareRed = UIColor(hexString: "#EBF4F5")
        let flareOrange = UIColor(hexString: "#FFFFFF")
        var bounds = view.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        gradient.colors = [flareRed.cgColor, flareOrange.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 2, y: 0)
        return gradient.createGradientImage(on: view)
    }
    
    class func thirdGradient(on view: UIView) -> UIImage? {
        let gradient = CAGradientLayer()
        let flareRed = UIColor(hexString: "#EC2778")
        let flareOrange = UIColor(hexString: "#EC2756")
        var bounds = view.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        gradient.colors = [flareRed.cgColor, flareOrange.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 2, y: 0)
        return gradient.createGradientImage(on: view)
    }
    
    private func createGradientImage(on view: UIView) -> UIImage? {
        var gradientImage: UIImage?
        UIGraphicsBeginImageContext(view.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
}


extension UINavigationBar {
    
    func createGradientBar() {
        guard let flareGradientImage = CAGradientLayer.primaryGradient(on: self) else {
            return print("Error creating gradient color!")
        }
        
        
        self.isTranslucent = false
        self.barTintColor = UIColor(patternImage: flareGradientImage)
    }
    
    func createSecondaryGradientBar() {
        guard let flareGradientImage = CAGradientLayer.secondaryGradient(on: self) else {
            return print("Error creating gradient color!")
        }
        
        
        self.isTranslucent = false
        self.barTintColor = UIColor(patternImage: flareGradientImage)
    }
    
    func createThirdGradientBar() {
        guard let flareGradientImage = CAGradientLayer.thirdGradient(on: self) else {
            return print("Error creating gradient color!")
        }
        
        
        self.isTranslucent = false
        self.barTintColor = UIColor(patternImage: flareGradientImage)
    }
    
    
}
