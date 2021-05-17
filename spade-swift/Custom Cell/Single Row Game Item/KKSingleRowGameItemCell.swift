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
    @IBOutlet weak var btnBetNow: UIButton!
    @IBOutlet weak var btnBetNowMarginBottom: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnBetNow.isHidden = true
        btnBetNowMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 20)
    }
}
