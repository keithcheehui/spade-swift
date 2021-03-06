//
//  KKColor.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import Foundation
import UIKit

extension UIColor {

    static let spade_white_FFFFFF = UIColor.init(hexCode: "#FFFFFF")
    static let spade_black_000000 = UIColor.init(hexCode: "#000000")
    static let spade_grey_BDBDBD = UIColor.init(hexCode: "#BDBDBD")
    static let spade_grey_B3C0E0 = UIColor.init(hexCode: "#B3C0E0")
    static let spade_orange_FFBA00 = UIColor.init(hexCode: "#FFBA00")
    static let spade_blue_292969 = UIColor.init(hexCode: "#292969")
    static let spade_blue_4850C6 = UIColor.init(hexCode: "#4850C6")
    static let spade_blue_5CB5DE = UIColor.init(hexCode: "#5CB5DE")
    static let spade_blue_2C336D = UIColor.init(hexCode: "#2C336D")
    static let spade_yellow_FFFF99 = UIColor.init(hexCode: "#FFFF99")
    static let spade_yellow_FFFF00 = UIColor.init(hexCode: "#FFFF00")
    static let spade_yellow_F9F53B = UIColor.init(hexCode: "#F9F53B")
    static let spade_green_8AD942 = UIColor.init(hexCode: "#8AD942")
    static let spade_green_74f56b = UIColor.init(hexCode: "#74f56b")
    
    

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
