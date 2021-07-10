//
//  KKVipItemCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 11/07/2021.
//

import UIKit

class KKVipItemCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgVip: UIImageView!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var imgBG: UIImageView!

    @IBOutlet weak var containerViewMarginTop: NSLayoutConstraint!
    @IBOutlet weak var containerViewMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var containerViewMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var containerViewMarginRight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgBG.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 8)
    }
}
