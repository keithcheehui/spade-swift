//
//  KKLiveChatCollectionViewCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 09/05/2021.
//

import Foundation
import UIKit

class KKLiveChatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblHotline: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1)
        containerView.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        containerView.layer.cornerRadius = 8
        
        lblHotline.textColor = UIColor.spade_white_FFFFFF
        lblHotline.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 16))
    }
}
