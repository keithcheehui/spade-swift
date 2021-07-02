//
//  KKNoBankViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 30/06/2021.
//

import UIKit

class KKNoBankViewController: KKBaseViewController {

    @IBOutlet weak var lblSetup: UILabel!
    @IBOutlet weak var lblStep1: UILabel!
    @IBOutlet weak var lblStep2: UILabel!
    
    @IBOutlet weak var containerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var containerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var imgBankCardWidth: NSLayoutConstraint!

    var isFromDeposit = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 50)
        containerMarginRight.constant = containerMarginLeft.constant
        imgBankCardWidth.constant = KKUtil.ConvertSizeByDensity(size: 30)

        lblSetup.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 16))
        lblStep1.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblStep2.font = lblStep1.font
        
        
        lblStep1.textColor = .spade_white_FFFFFF
        lblStep2.textColor = lblStep1.textColor
        
        lblStep1.text = KKUtil.languageSelectedStringForKey(key: "no_bank_liner_step_1")
        lblStep2.text = KKUtil.languageSelectedStringForKey(key: "no_bank_liner_step_2")

        if isFromDeposit {
            lblSetup.text = KKUtil.languageSelectedStringForKey(key: "no_bank_liner_deposit")
        } else {
            lblSetup.text = KKUtil.languageSelectedStringForKey(key: "no_bank_liner_withdraw")
        }
    }
}
