//
//  KKAddBankViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/05/2021.
//

import Foundation
import UIKit

class KKAddBankViewController: KKBaseViewController {
    
    @IBOutlet weak var lblWithdrawAmount: UILabel!
    @IBOutlet weak var txtWithdrawAmountView: UIView!
    @IBOutlet weak var txtWithdrawAmount: UITextField!
    @IBOutlet weak var lblNotice: UILabel!

    @IBOutlet weak var addBankContainer: UIView!
    @IBOutlet weak var lblWithdraw: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    @IBOutlet weak var bankListContainer: UIView!
    @IBOutlet weak var lblSelectBank: UILabel!

    @IBOutlet weak var withdrawContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var addBankContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
    }
    
    func initialLayout(){
        withdrawContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        btnConfirmHeight.constant = KKUtil.ConvertSizeByDensity(size: 35)
        
        txtWithdrawAmountView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        addBankContainer.backgroundColor = UIColor(white: 0, alpha: 0.3)

        txtWithdrawAmountView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 8)
        addBankContainer.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 8)
        addBankContainer.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1)
        addBankContainer.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        
        lblWithdrawAmount.text = KKUtil.languageSelectedStringForKey(key: "withdraw_withdraw_amount")
        lblNotice.text = KKUtil.languageSelectedStringForKey(key: "withdraw_notice")
        lblWithdraw.text = KKUtil.languageSelectedStringForKey(key: "withdraw_withdraw")
        lblDescription.text = KKUtil.languageSelectedStringForKey(key: "withdraw_description")
        lblSelectBank.text = KKUtil.languageSelectedStringForKey(key: "withdraw_select_bank")

        txtWithdrawAmount.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "withdraw_withdraw_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        
        lblWithdrawAmount.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        txtWithdrawAmount.font = lblWithdrawAmount.font
        lblNotice.font = lblWithdrawAmount.font
        lblSelectBank.font = lblWithdrawAmount.font
        lblWithdraw.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblDescription.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 8))
        
        lblWithdrawAmount.textColor = UIColor.spade_white_FFFFFF
        txtWithdrawAmount.textColor = lblWithdrawAmount.textColor
        lblWithdraw.textColor = lblWithdrawAmount.textColor
        lblDescription.textColor = lblWithdrawAmount.textColor
        lblSelectBank.textColor = lblWithdrawAmount.textColor
        lblNotice.textColor = UIColor.spade_orange_FFBA00
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){

    }
    
    @IBAction func btnConfirmDidPressed(){

    }
}
