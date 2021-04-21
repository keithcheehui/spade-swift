//
//  KKFont.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import Foundation
import UIKit

extension UIFont {
    
    public enum NeutraType: String {
        case Medium         = "NeutraDisp-Medium"
        case Titling        = "NeutraDisp-Titling"
        case Bold           = "NeutraText-Bold"
    }
    
    public enum HaarlemType: String {
        case Deco           = "HaarlemDecoDEMO"
    }
        
    static func Neutra(_ type: NeutraType = .Medium, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
    
}
