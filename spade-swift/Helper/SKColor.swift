//
//  SKColor.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import Foundation
import UIKit

extension UIColor {

    static let cinemoi_white_FFFFFF = UIColor.init(hexCode: "#FFFFFF")
    static let cinemoi_black_000000 = UIColor.init(hexCode: "#000000")
    
    convenience init(red: Int, green: Int, blue: Int, alphaValue: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        let redRgb = CGFloat(red) / 255.0
        let greenRgb = CGFloat(green) / 255.0
        let blueRgb = CGFloat(blue) / 255.0
        
        self.init(red: redRgb, green: greenRgb, blue: blueRgb, alpha: alphaValue)
    }
    
    convenience init(netHex: Int, alpha: CGFloat = 1.0) {
        let redRgb = (netHex >> 16) & 0xff
        let greenRgb = (netHex >> 8) & 0xff
        let blueRgb = netHex & 0xff
        
        self.init(red: redRgb, green: greenRgb, blue: blueRgb, alphaValue: alpha)
    }
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        self.init(netHex: Int(color))
    }
}
