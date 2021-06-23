//
//  KKBonusItemCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 22/05/2021.
//

import Foundation
import UIKit

class KKBonusItemCell: UICollectionViewCell {
    
    @IBOutlet weak var imgBonusBG: UIImageView!
    @IBOutlet weak var imgButton: UIImageView!

    @IBOutlet weak var imgButtonHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgBonusBG.backgroundColor = .spade_grey_BDBDBD
        imgButtonHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
    }
}
