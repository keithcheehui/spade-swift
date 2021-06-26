//
//  KKSingleRowGameItemCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 16/05/2021.
//

import Foundation
import UIKit

class KKSingleRowGameItemCell: UICollectionViewCell {
    
    @IBOutlet weak var imgGameImage: UIImageView!
    @IBOutlet weak var btnBetNow: UIView!
    @IBOutlet weak var btnBetNowMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var btnBetNowHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnBetNow.isHidden = true
        btnBetNowMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 15)
        btnBetNowHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
    }
}
