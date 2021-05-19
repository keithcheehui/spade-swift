//
//  KKLiveCasinoItemCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 16/05/2021.
//

import Foundation
import UIKit

class KKLiveCasinoItemCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgGirlIcon: UIImageView!
    @IBOutlet weak var imgGameIcon: UIImageView!
    @IBOutlet weak var lblGameName: UILabel!
    @IBOutlet weak var imgHover: UIImageView!
    
    @IBOutlet weak var lblGameNameHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblGameNameHeight.constant = KKUtil.ConvertSizeByDensity(size: 15)
        
        bgView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        lblGameName.textColor = UIColor.spade_white_FFFFFF
        lblGameName.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 11))
        imgHover.isHidden = true
    }
}
