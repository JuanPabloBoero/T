//
//  UIColor+extensions.swift
//  T
//
//  Created by Juan Pablo Boero Alvarez on 23/12/16.
//  Copyright © 2016 Juan Pablo Boero Alvarez. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    class func colorFromHexString(_ hex:String) -> UIColor {
        var colorString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (colorString.hasPrefix("#")) {
            colorString = (colorString as NSString).substring(from: 1)
        }
        
        if (colorString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (colorString as NSString).substring(to: 2)
        let gString = ((colorString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((colorString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
}

