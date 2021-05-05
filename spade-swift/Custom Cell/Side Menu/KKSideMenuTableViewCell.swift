//
//  KKSideMenuTableViewCell.swift
//  spade-swift
//
//  Created by Keith CheeHui on 04/05/2021.
//

import UIKit

class KKSideMenuTableViewCell: UITableViewCell {

    struct CellViewConstant {
        
        static let cellWidth = CGFloat(150)
        static let iconSize = CGFloat(25)
        static let seperatorHeight = CGFloat(10)
    }

    var sideMenuIcon:               UIImageView!
    var sideMenuTitle:              UILabel!
    var sideMenuSeperator:          UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        sideMenuIcon = UIImageView.init()
        sideMenuIcon.backgroundColor = .clear
        sideMenuIcon.contentMode = .scaleAspectFill
        self.contentView.addSubview(sideMenuIcon)
        
        sideMenuTitle = UILabel.init()
        sideMenuTitle.font = .systemFont(ofSize: 10)
        sideMenuTitle.textColor = .spade_white_FFFFFF
        sideMenuTitle.textAlignment = .left
        sideMenuTitle.numberOfLines = 0
        self.contentView.addSubview(sideMenuTitle)
        
        sideMenuSeperator = UIImageView.init()
        sideMenuSeperator.backgroundColor = .clear
        sideMenuSeperator.contentMode = .scaleAspectFit
        sideMenuSeperator.image = UIImage(named: "bg_separator")
        self.contentView.addSubview(sideMenuSeperator)
    }
    
    func setUpSideMenuTitleWithIcon(iconImage: UIImage, titleString: String) {
        
        let maximumLabelSize = CGSize(width: CellViewConstant.cellWidth - ConstantSize.paddingSecondary*2.5 - CellViewConstant.iconSize, height: .greatestFiniteMagnitude)
        
        let sideMenuTitleAttributes: [NSAttributedString.Key: Any] = [
            .font            : UIFont.systemFont(ofSize: 10),
        ]
        
        let expectedSideMenuTitleLabelSize = KKUtil.getLabelSize(text: titleString,
                                                                 maximumLabelSize: maximumLabelSize,
                                                                 attributes: sideMenuTitleAttributes)
        
        sideMenuIcon.image = iconImage
        sideMenuIcon.frame = CGRect(x: ConstantSize.paddingSecondary, y: ConstantSize.paddingSecondaryHalf, width: CellViewConstant.iconSize, height: CellViewConstant.iconSize)
        
        sideMenuTitle.text = titleString
        sideMenuTitle.frame = CGRect(x: ConstantSize.paddingSecondary*1.5 + CellViewConstant.iconSize, y: (ConstantSize.paddingSecondary + CellViewConstant.iconSize)/2 - expectedSideMenuTitleLabelSize.height/2, width: CellViewConstant.cellWidth - ConstantSize.paddingSecondary*2.5 - CellViewConstant.iconSize, height: expectedSideMenuTitleLabelSize.height)
        
        sideMenuSeperator.frame = CGRect(x: 0, y: ConstantSize.paddingSecondary + CellViewConstant.iconSize, width: CellViewConstant.cellWidth, height: CellViewConstant.seperatorHeight)
    }
    
    class func calculateSideMenuHeight() -> CGFloat {
        
        return ConstantSize.paddingSecondary + CellViewConstant.iconSize + CellViewConstant.seperatorHeight
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
