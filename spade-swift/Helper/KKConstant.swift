//
//  KKConstant.swift
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
    static let leftNotchWidth = CGFloat(44)
    static let navBarHeight = CGFloat(60)
}

struct ConstantSize {
    
    static let paddingStandard = CGFloat(24)
    static let paddingSecondary = CGFloat(16)
    
    static let paddingDouble = paddingStandard*2
    static let paddingHalf = paddingStandard/2
    
    static let paddingSecondaryDouble = paddingSecondary*2
    static let paddingSecondaryHalf = paddingSecondary/2
    
    static let textFieldHeight = CGFloat(40)
    static let textFieldSeperatorHeight = CGFloat(1)
    
    static let navBarBtnWidth = CGFloat(65)
    static let navBarSeperatorHeight = CGFloat(2)

    static let ssoLabelFont = KKUtil.ConvertSizeByDensity(size: 14)
    static let ssoLabelSmallFont = KKUtil.ConvertSizeByDensity(size: 12)
    
    
    static let imgBackWidth = KKUtil.ConvertSizeByDensity(size: 35)
    static let sideMenuWidth = KKUtil.ConvertSizeByDensity(size: 150)
    static let imgMenuIconWidth = KKUtil.ConvertSizeByDensity(size: 25)
    static let menuItemHeight = KKUtil.ConvertSizeByDensity(size: 40)
    static let separatorHeight = KKUtil.ConvertSizeByDensity(size: 10)
    static let headerContainerMarginLeft = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 20 : 30)
    static let menuItemMarginLeft = KKUtil.ConvertSizeByDensity(size: 15)
}

struct CellIdentifier {
    
    static let sideMenuTableCellIdentifier = "SIDE_MENU_TABLE_CELL_IDENTIFIER"
    static let announcementTableCellIdentifier = "KKAnnouncementTableCell"
    static let bankTableCellIdentifier = "KKBankTableCell"

    static let liveChatCollectionViewCellIdentifier = "KKLiveChatCollectionViewCell"
}

struct Spade {
    
    struct DevServer {
        static let baseApiURL: String = ""
    }
    
    struct ProdServer {
        static let baseApiURL: String = ""
    }
}
