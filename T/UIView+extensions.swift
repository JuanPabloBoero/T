//
//  UIView+extensions.swift
//  T
//
//  Created by Juan Pablo Boero Alvarez on 22/12/16.
//  Copyright © 2016 Juan Pablo Boero Alvarez. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func gradientWith(topLeftColor: UIColor, bottomRightColor: UIColor) {
        
        let gradient = CAGradientLayer()
        let gradientCustomName = "custom_gradient"
        gradient.name = gradientCustomName
        gradient.colors = [topLeftColor.cgColor, bottomRightColor.cgColor]
        gradient.locations = [0 , 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        // Clean previous sublayers
        var subLayersFinal = [CALayer]()
        if let subLayers = layer.sublayers {
            subLayersFinal = subLayers
            for (index, gradientLayer) in subLayersFinal.enumerated() {
                if gradientLayer.name == gradientCustomName {
                    // If we had already added gradient layers with this custom extension, we clean them before adding new ones.
                    subLayersFinal.remove(at: index)
                }
            }
            // Added the cleaned subLayers array, we only cleaned the sub layers that were inserted by this extension.
            layer.sublayers = subLayersFinal
        }
        
        // Add gradient layer
        layer.insertSublayer(gradient, at: 0)
        superview?.setNeedsLayout()
        superview?.setNeedsDisplay()
        setNeedsDisplay()
        setNeedsLayout()
        gradient.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }
    
    func cleanCustomGradients() {
        
        let gradientCustomName = "custom_gradient"
        
        // Clean previous sublayers
        var subLayersFinal = [CALayer]()
        if let subLayers = layer.sublayers {
            subLayersFinal = subLayers
            for (index, gradientLayer) in subLayersFinal.enumerated() {
                if gradientLayer.name == gradientCustomName {
                    // If we had already added gradient layers with this custom extension, we clean them before adding new ones.
                    subLayersFinal.remove(at: index)
                }
            }
            // Added the cleaned subLayers array, we only cleaned the sub layers that were inserted by this extension.
            layer.sublayers = subLayersFinal
        }
    }
    
    func addShadow (offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = nil, shouldRasterize: Bool) {
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        self.layer.shouldRasterize = shouldRasterize
        
        if let r = cornerRadius {
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
    }
    
    func addBorder (width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.masksToBounds = true
    }
    
}
