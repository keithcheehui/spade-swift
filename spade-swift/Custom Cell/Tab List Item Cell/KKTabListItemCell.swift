//
//  KKTabListItemCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 26/06/2021.
//

import UIKit

class KKTabListItemCell: UICollectionViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgHover: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        container.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        container.maskedCornersWidthRadius(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: KKUtil.ConvertSizeByDensity(size: 8))
        imgHover.maskedCornersWidthRadius(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: KKUtil.ConvertSizeByDensity(size: 8))

        lblTitle.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblTitle.textColor = .spade_white_FFFFFF
    }
}
