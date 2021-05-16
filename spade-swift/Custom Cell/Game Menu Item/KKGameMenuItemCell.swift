//
//  KKGameMenuItemCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 16/05/2021.
//

import Foundation
import UIKit

class KKGameMenuItemCell: UICollectionViewCell {
    
    @IBOutlet weak var imgHover: UIImageView!
    @IBOutlet weak var imgMenuIcon: UIImageView!
    @IBOutlet weak var lblMenuName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblMenuName.textColor = UIColor.spade_white_FFFFFF
        lblMenuName.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 16))
        imgHover.isHidden = true
    }
}
