//
//  SKConstant.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import Foundation
import UIKit

struct ScreenSize {
    
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let maxLength = max(width, height)
    static let minLength = min(width, height)
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    static let navBarHeight = CGFloat(50)
    static let navBarTotalHeight = statusBarHeight + navBarHeight
}

struct ConstantSize {
    
    #if os(tvOS)
    static let paddingStandard = CGFloat(50)
    static let paddingSecondary = CGFloat(32)
    static let defaultCornerRadius = CGFloat(8)
    #else
    static let paddingStandard = CGFloat(24)
    static let paddingSecondary = CGFloat(16)
    #endif
    
    static let paddingDouble = paddingStandard*2
    static let paddingHalf = paddingStandard/2
    
    static let paddingSecondaryDouble = paddingSecondary*2
    static let paddingSecondaryHalf = paddingSecondary/2
    
    static let textFieldHeight = CGFloat(40)
    static let textFieldSeperatorHeight = CGFloat(1)
    
    static let navBarBtnWidth = CGFloat(65)
    static let navBarSeperatorHeight = CGFloat(2)
}