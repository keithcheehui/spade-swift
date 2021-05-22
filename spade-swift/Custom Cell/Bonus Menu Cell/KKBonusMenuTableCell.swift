//
//  KKBonusMenuTableCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 22/05/2021.
//

import Foundation
import UIKit

class KKBonusMenuTableCell: UITableViewCell {
    
    @IBOutlet weak var imgHover: UIImageView!
    @IBOutlet weak var lblMenuName: UILabel!
    
    @IBOutlet weak var imgSeparatorHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgSeparatorHeight.constant = KKUtil.ConvertSizeByDensity(size: 5)
        
        lblMenuName.textColor = UIColor.spade_white_FFFFFF
        lblMenuName.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        imgHover.isHidden = true
    }
}
