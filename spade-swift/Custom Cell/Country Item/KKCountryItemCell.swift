//
//  KKCountryItemCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 16/05/2021.
//

import Foundation
import UIKit

class KKCountryItemCell: UICollectionViewCell {
    
    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var lblCountryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgCountry.layer.masksToBounds = true
        imgCountry.layer.cornerRadius = self.imgCountry.frame.size.height / 2
        imgCountry.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 0)
        imgCountry.layer.borderColor = UIColor(white: 1, alpha: 1).cgColor
        imgCountry.clipsToBounds = true
        
        lblCountryName.textColor = UIColor.spade_white_FFFFFF
        lblCountryName.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 14))
    }
}
