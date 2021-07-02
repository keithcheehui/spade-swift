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
    @IBOutlet weak var lblAccountName: UILabel!
    @IBOutlet weak var lblBankAccount: UILabel!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var imgSelectedWidth: NSLayoutConstraint!
    @IBOutlet weak var lblAccountNameHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        containerView.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1)
        containerView.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        containerView.layer.cornerRadius = 8
        
        imgSelectedWidth.constant = KKUtil.ConvertSizeByDensity(size: 20)

        lblBankName.textColor = UIColor.spade_white_FFFFFF
        lblAccountName.textColor = lblBankName.textColor
        lblBankAccount.textColor = lblBankName.textColor

        lblBankName.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 14))
        lblAccountName.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblBankAccount.font = lblBankName.font
    }
}
