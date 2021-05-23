//
//  KKMessageTableCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 23/05/2021.
//

import Foundation
import UIKit

class KKMessageTableCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var lblMsgTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMsgContent: UILabel!
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomLabelHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        containerView.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1)
        containerView.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        containerView.layer.cornerRadius = 8
        
        topViewHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        bottomLabelHeight.constant = 0
        
        lblMsgTitle.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblDate.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblMsgContent.font = lblDate.font

        lblMsgTitle.textColor = UIColor.spade_white_FFFFFF
        lblDate.textColor = lblMsgTitle.textColor
        lblMsgContent.textColor = lblMsgTitle.textColor
        
        lblMsgTitle.text = "Welcome Gifts"
        lblDate.text = "2021-01-23 19:00:00"
        lblMsgContent.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin vulputate, lorem a blandit fermentum, neque lacus pulvinar orci, et scelerisque leo magna id urna. Mauris vitae malesuada ex."
    }
}

