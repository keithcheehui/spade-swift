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
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblHotline: UILabel!
    
    @IBOutlet weak var imgMarginTop : NSLayoutConstraint!
    @IBOutlet weak var imgMarginHeight : NSLayoutConstraint!
    @IBOutlet weak var bottomContainerMarginLeft : NSLayoutConstraint!
    @IBOutlet weak var bottomContainerMarginRight : NSLayoutConstraint!
    @IBOutlet weak var bottomContainerMarginBottom : NSLayoutConstraint!
    @IBOutlet weak var lblHotlineMarginTop : NSLayoutConstraint!
    @IBOutlet weak var lblHotlineMarginBottom : NSLayoutConstraint!
    @IBOutlet weak var btnContainerHeight : NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 15)
        bottomContainerMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 15)
        bottomContainerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 15)
        bottomContainerMarginRight.constant = KKUtil.ConvertSizeByDensity(size: 15)
        imgMarginHeight.constant = KKUtil.ConvertSizeByDensity(size: 60)
        btnContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        lblHotlineMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 10)
        lblHotlineMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 10)
        
        containerView.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1)
        containerView.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        containerView.layer.cornerRadius = 8
        
        lblHotline.textColor = UIColor.spade_white_FFFFFF
        lblHotline.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
    }
}
