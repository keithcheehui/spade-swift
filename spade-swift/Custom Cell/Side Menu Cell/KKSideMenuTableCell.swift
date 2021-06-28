//
//  KKSideMenuTableCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 29/06/2021.
//

import UIKit

class KKSideMenuTableCell: UITableViewCell {

    @IBOutlet weak var imgHover: UIImageView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblName: UILabel!

    @IBOutlet weak var imgIconWidth: NSLayoutConstraint!
    @IBOutlet weak var menuItemMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var menuItemMarginRight: NSLayoutConstraint!
    @IBOutlet weak var imgIconMarginRight: NSLayoutConstraint!
    @IBOutlet weak var imgSeparatorHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        initialLayout()
    }
    
    func initialLayout() {
        imgIconWidth.constant = ConstantSize.imgMenuIconWidth
        imgSeparatorHeight.constant = ConstantSize.separatorHeight
        menuItemMarginLeft.constant = ConstantSize.menuItemMarginLeft
        menuItemMarginRight.constant = menuItemMarginLeft.constant
        imgIconMarginRight.constant = KKUtil.ConvertSizeByDensity(size: 10)
        
        lblName.font = ConstantSize.sideMenuFont
        lblName.textColor = .spade_white_FFFFFF
    }
}
