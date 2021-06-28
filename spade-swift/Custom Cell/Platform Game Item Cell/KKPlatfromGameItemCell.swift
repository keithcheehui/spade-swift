//
//  KKPlatfromGameItemCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 29/06/2021.
//

import UIKit

class KKPlatfromGameItemCell: UICollectionViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblName.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblName.textColor = .spade_white_FFFFFF
    }

}
