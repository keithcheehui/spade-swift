//
//  KKBankTableCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/05/2021.
//

import Foundation
import UIKit

class KKBankTableCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgBank: UIImageView!
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var lblBankAccount: UILabel!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var imgSelectedWidth: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        containerView.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1)
        containerView.layer.borderColor = UIColor(white: 1, alpha: 0.5).cgColor
        containerView.layer.cornerRadius = 8
        
        imgSelectedWidth.constant = KKUtil.ConvertSizeByDensity(size: 20)

        lblBankName.textColor = UIColor.spade_white_FFFFFF
        lblBankAccount.textColor = UIColor.spade_white_FFFFFF
        
        lblBankName.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblBankAccount.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
    }
}
