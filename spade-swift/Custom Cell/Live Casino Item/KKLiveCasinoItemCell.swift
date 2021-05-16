//
//  KKLiveCasinoItemCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 16/05/2021.
//

import Foundation
import UIKit

class KKLiveCasinoItemCell: UICollectionViewCell {
    
    @IBOutlet weak var imgGirlIcon: UIImageView!
    @IBOutlet weak var imgGameIcon: UIImageView!
    @IBOutlet weak var lblGameName: UILabel!
    @IBOutlet weak var imgHover: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        lblGameName.textColor = UIColor.spade_white_FFFFFF
        lblGameName.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 11))
        imgHover.isHidden = true
    }
}
