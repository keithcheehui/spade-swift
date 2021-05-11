//
//  KKAnnouncementTableCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 10/05/2021.
//

import Foundation
import UIKit

class KKAnnouncementTableCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        containerView.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1)
        containerView.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        containerView.layer.cornerRadius = 8
        
        lblDate.textColor = UIColor.spade_white_FFFFFF
        lblTitle.textColor = UIColor.spade_white_FFFFFF
        
        lblDate.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblTitle.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
    }
}
