//
//  UIFont + Extension.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import UIKit

extension UIFont {
    
    class var navLargeTitleFont: UIFont {
        return UIFont.robotoBoldFont(size: 35.0,autoAjust: false)
    }
    
    class var navTitleFont: UIFont {
        return UIFont.robotoBoldFont(size: 20.0,autoAjust: false)
    }
    
    class func robotoFont(size: CGFloat, autoAjust: Bool = true) -> UIFont {
        return UIFont.screenAdjustedAppFont(name: "Roboto", size: size, autoAjust: autoAjust)
    }
        
    class func robotoBoldFont(size: CGFloat, autoAjust: Bool = true) -> UIFont {
        return UIFont.screenAdjustedAppFont(name: "Roboto-Bold", size: size, autoAjust: autoAjust)
    }
    
    class func robotoMediumFont(size: CGFloat, autoAjust: Bool = true) -> UIFont {
        return UIFont.screenAdjustedAppFont(name: "Roboto-Medium", size: size, autoAjust: autoAjust)
    }
        
    class func screenAdjustedAppFont(name: String, size: CGFloat, autoAjust : Bool) -> UIFont {
        
        if !autoAjust { return UIFont(name: name, size: size)! }
        
        /* 1.4 ratio font for tablet ipad sizes**/
        if iOSDeviceSizes.tabletSize.getBool() {
            return UIFont(name: name, size: size * 1.4)!
        }else if iOSDeviceSizes.plusSize.getBool() {
            /* 1.2 ratio font for iphone plus sizes**/
            return UIFont(name: name, size: size * 1.2)!
        }else if iOSDeviceSizes.miniSize.getBool() {
            /* 0.9 ratio font for iphone SE and mini sizes**/
            return UIFont(name: name, size: size * 0.9)!
        }
        
            return UIFont(name: name, size: size)!
    }
    
}


